import com.danielasfregola.twitter4s.TwitterRestClient
import scala.concurrent.ExecutionContext.Implicits.global
import scala.util.Properties

object HelloWorld extends App {

  scala.util.Properties.envOrElse("TWITTER_CONSUMER_TOKEN_KEY", "fuck")
  scala.util.Properties.envOrElse("TWITTER_CONSUMER_TOKEN_SECRET","fuck")
  scala.util.Properties.envOrElse("TWITTER_ACCESS_TOKEN_KEY", "fuck")
  scala.util.Properties.envOrElse("TWITTER_ACCESS_TOKEN_SECRET", "fuck")

  val restClient = TwitterRestClient()

  restClient.homeTimeline().map{ ratedData =>
    val tweets = ratedData.data
    tweets.foreach(tweet => println(tweet.text))
  }
}
