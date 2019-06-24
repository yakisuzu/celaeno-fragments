package celaenoFragments

import com.typesafe.scalalogging.LazyLogging

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

object HelloWorld extends App with LazyLogging {
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

  // TODO 本来は終了しないけど、処理ができるまでいったんsleepし続けるように
  Thread.sleep(24.hours.toMillis)
}
