package celaenoFragments

case class TrendsEntity(trends: Seq[String]) {
  def ignoreHashTagTrends(): Seq[String] =
    trends.filter(_.head != '#')
}
