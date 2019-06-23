package celaenoFragments

import com.danielasfregola.twitter4s.entities.{
  LocationTrends,
  RateLimit,
  RatedData,
  Trend
}

import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.{Future, Promise}

object HelloWorld extends App {
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
      "交流戦優勝",
    )
  )

  trends.map { ratedData =>
    val trends = ratedData.data
    trends.foreach(trend => println(trend.trends))
  }

  def trendsMock(
    trendNames: Seq[String]
  ): Future[RatedData[Seq[LocationTrends]]] = {
    val p = Promise[RatedData[Seq[LocationTrends]]]
    p.success(
      new RatedData[Seq[LocationTrends]](
        rate_limit = RateLimit(limit = 100, remaining = 0, reset = 0),
        data = Seq(
          LocationTrends(
            as_of = "",
            created_at = "",
            locations = Seq.empty,
            trends = trendNames.map { name =>
              Trend(name = name, query = "", url = "", tweet_volume = None)
            }
          )
        )
      )
    )
    p.future
  }
}
