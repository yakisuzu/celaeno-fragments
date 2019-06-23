import com.danielasfregola.twitter4s.entities.{
  LocationTrends,
  RateLimit,
  RatedData,
  Trend
}

import scala.concurrent.{Future, Promise}

package object celaenoFragments {
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
