package celaenoFragments

import com.danielasfregola.twitter4s.entities.{LocationTrends, RatedData}
import com.typesafe.scalalogging.LazyLogging

import scala.concurrent.{ExecutionContext, Future}

trait TrendsRepository extends LazyLogging {
  implicit val executor: ExecutionContext

  def fetchTrendNames(): Future[TrendsEntity] = {
    // TODO mock
    val trends: Future[RatedData[Seq[LocationTrends]]] = trendsMock(
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

    trends.map(r => TrendsEntity(r.data.flatMap(_.trends.map(_.name))))(executor)
  }
}

object TrendsRepository {
  def apply()(implicit _executor: ExecutionContext): TrendsRepository =
    new TrendsRepository() {
      override implicit val executor: ExecutionContext = _executor
    }
}
