version := "0.1"
scalaVersion := "2.12.7"
name := "celaeno-fragments"

resolvers += Resolver.sonatypeRepo("releases")

libraryDependencies ++= Seq(
  "com.danielasfregola" %% "twitter4s" % "5.5"
)