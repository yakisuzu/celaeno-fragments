package celaenoFragments

import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport
import com.google.api.client.json.jackson2.JacksonFactory
import com.google.api.services.customsearch.model.Result
import com.google.api.services.customsearch.{Customsearch, CustomsearchRequestInitializer}
import com.typesafe.config.{Config, ConfigFactory}
import com.typesafe.scalalogging.LazyLogging
import com.worksap.nlp.sudachi.{Dictionary, DictionaryFactory, Morpheme, Tokenizer}

import scala.collection.JavaConverters._
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._
import scala.util.Try

object HelloWorld extends App with LazyLogging {
  lazy val conf: Config    = ConfigFactory.load()
  lazy val cseName: String = conf.getString("app.cse.name")
  lazy val cseApi: String  = conf.getString("app.cse.api")
  lazy val cseCx: String   = conf.getString("app.cse.cx")

  // twitter
  /*
  scala.util.Properties.envOrElse("TWITTER_CONSUMER_TOKEN_KEY", "fuck")
  scala.util.Properties.envOrElse("TWITTER_CONSUMER_TOKEN_SECRET","fuck")
  scala.util.Properties.envOrElse("TWITTER_ACCESS_TOKEN_KEY", "fuck")
  scala.util.Properties.envOrElse("TWITTER_ACCESS_TOKEN_SECRET", "fuck")
  val restClient = TwitterRestClient(ConsumerToken("", ""), AccessToken("", ""))
  val woeId = 23424856
  restClient.trends(woeId).map { ratedData =>
    val trends = ratedData.data
    trends.foreach(trend => println(trend.trends))
  }
   */
  val trends = trendsMock(
    Seq(
      "SOS団",
      "#鉄腕DASH",
      "#モヤさま",
      "#パワスプ",
      "#たと打ってタピオカが出てきたら陽キャ",
      "リスグラシュー",
      "ハルヒ",
      "キセキ",
      "#ダーウィンが来た",
      "交流戦優勝"
    )
  )

  trends.map { ratedData =>
    val trends = ratedData.data
    trends.foreach(trend => trend.trends.foreach(t => logger.info(t.name)))
  }(global)

  // CSE
  lazy val cseClient = new Customsearch.Builder(
    GoogleNetHttpTransport.newTrustedTransport(),
    JacksonFactory.getDefaultInstance,
    null
  ).setApplicationName(cseName)
    .setCustomsearchRequestInitializer(new CustomsearchRequestInitializer(cseApi))
    .build()
    .cse()

  case class CseResultEntity(url: String, title: String, snippet: String)
  lazy val cseResults: Seq[Result]      = cseClient.list("リスグラシュー").setCx(cseCx).execute().getItems.asScala
  val cseEntities: Seq[CseResultEntity] = cseResults.map(r => CseResultEntity(r.getFormattedUrl, r.getTitle, r.getSnippet))

  // Sudachi
  // TODO dicを/src/main/resourcesにおく
  val dict: Try[Dictionary] = Try(new DictionaryFactory().create(null, null, false))
  val tokenizer: Tokenizer  = dict.get.create()
  val ms = cseEntities.flatMap { e =>
    val morphemes: Seq[Morpheme] = tokenizer.tokenize(Tokenizer.SplitMode.C, e.snippet).asScala
    morphemes
  }
  ms.foreach(m => logger.info(s"${m.surface}/${m.partOfSpeech.asScala.mkString(",")}/${m.normalizedForm}"))

  // TODO 本来は終了しないけど、処理ができるまでいったんsleepし続けるように
  Thread.sleep(24.hours.toMillis)
}
