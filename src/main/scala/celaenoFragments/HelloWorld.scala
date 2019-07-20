package celaenoFragments

import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport
import com.google.api.client.json.jackson2.JacksonFactory
import com.google.api.services.customsearch.{Customsearch, CustomsearchRequestInitializer}
import com.typesafe.config.{Config, ConfigFactory}
import com.typesafe.scalalogging.LazyLogging

import scala.collection.JavaConverters._
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

object HelloWorld extends App with LazyLogging {
  lazy val conf: Config    = ConfigFactory.load()
  lazy val cseName: String = conf.getString("app.cse.name")
  lazy val cseApi: String  = conf.getString("app.cse.api")
  lazy val cseCx: String   = conf.getString("app.cse.cx")

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

  lazy val cseClient = new Customsearch.Builder(
    GoogleNetHttpTransport.newTrustedTransport(),
    JacksonFactory.getDefaultInstance,
    null
  ).setApplicationName(cseName)
    .setCustomsearchRequestInitializer(new CustomsearchRequestInitializer(cseApi))
    .build()
    .cse()

  val results = cseClient.list("cars").setCx(cseCx).execute().getItems.asScala
  results.foreach { r =>
    logger.info(r.toString)
  }

  // TODO 本来は終了しないけど、処理ができるまでいったんsleepし続けるように
  Thread.sleep(24.hours.toMillis)
}
