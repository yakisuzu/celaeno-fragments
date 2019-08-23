package celaenoFragments

import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport
import com.google.api.client.json.jackson2.JacksonFactory
import com.google.api.services.customsearch.model.Result
import com.google.api.services.customsearch.{Customsearch, CustomsearchRequestInitializer}
import com.typesafe.config.{Config, ConfigFactory}
import com.typesafe.scalalogging.LazyLogging
import com.ullink.slack.simpleslackapi.SlackSession
import com.ullink.slack.simpleslackapi.impl.SlackSessionFactory
import com.worksap.nlp.sudachi.{Dictionary, DictionaryFactory, Tokenizer}

import scala.collection.JavaConverters._
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._
import scala.concurrent.{Await, Future}
import scala.util.Try

object HelloWorld extends App with LazyLogging {
  lazy val conf: Config       = ConfigFactory.load()
  lazy val cseName: String    = conf.getString("app.cse.name")
  lazy val cseApi: String     = conf.getString("app.cse.api")
  lazy val cseCx: String      = conf.getString("app.cse.cx")
  lazy val slackToken: String = conf.getString("app.slack.token")

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

  val trendNamesF: Future[Seq[String]] = trends.map(_.data.flatMap(_.trends.map(_.name)))(global)
  val trendNames: Seq[String]          = Await.result(trendNamesF, Duration.Inf)

  // CSE
  lazy val cseClient = new Customsearch.Builder(
    GoogleNetHttpTransport.newTrustedTransport(),
    JacksonFactory.getDefaultInstance,
    null
  ).setApplicationName(cseName)
    .setCustomsearchRequestInitializer(new CustomsearchRequestInitializer(cseApi))
    .build()
    .cse()

  case class CseResultsEntity(trendName: String, snippets: Seq[String])
  val cseEntities: Seq[CseResultsEntity] = trendNames.map { trendName: String =>
    val cseResults: Seq[Result] = cseClient.list(trendName).setCx(cseCx).execute().getItems.asScala
    CseResultsEntity(trendName, cseResults.map(_.getSnippet))
  }

  // Sudachi
  case class MorphemeEntity(normalizedForm: String, count: Int)
  case class SudachiResultsEntity(trendName: String, morphemes: Seq[MorphemeEntity])
  val dict: Try[Dictionary] = Try(new DictionaryFactory().create(null, null, false))
  val tokenizer: Tokenizer  = dict.get.create()
  val sudachiEntities: Seq[SudachiResultsEntity] = cseEntities.map { entity: CseResultsEntity =>
    val ms: Seq[MorphemeEntity] = entity.snippets
      .flatMap(tokenizer.tokenize(Tokenizer.SplitMode.C, _).asScala)
      .groupBy(_.normalizedForm)
      .toSeq
      .map(t => MorphemeEntity(t._1, t._2.length))
      .sortWith(_.count > _.count)
      .take(10)
    SudachiResultsEntity(entity.trendName, ms)
  }
  //  ms.foreach(m => logger.info(s"${m.surface}/${m.partOfSpeech.asScala.mkString(",")}/${m.normalizedForm}"))

  // slack
  lazy val session: SlackSession = SlackSessionFactory.getSlackSessionBuilder(slackToken).build()
//  val channel: SlackChannel
//  session.sendMessage(channel, "")

  // TODO 本来は終了しないけど、処理ができるまでいったんsleepし続けるように
  Thread.sleep(24.hours.toMillis)
}
