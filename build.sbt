version := "0.1"
scalaVersion := "2.12.8"
name := "celaeno-fragments"

resolvers += Resolver.sonatypeRepo("releases")

libraryDependencies ++= Seq(
  "com.danielasfregola" %% "twitter4s" % "6.1"
)

assemblyOutputPath in assembly := file(s"ops/${name.value}.jar")

// https://docs.scala-lang.org/overviews/compiler-options/index.html
scalacOptions ++= Seq(
  // Standard Settings
  "-language:_",  // Enable or disable language features
  "-deprecation", // Emit warning and location for usages of deprecated APIs.
  "-encoding",
  "utf8",       // Specify character encoding used by source files.
  "-feature",   // Emit warning and location for usages of features that should be imported explicitly.
  "-unchecked", // Enable additional warnings where generated code depends on assumptions.
  // Private Settings
  "-opt:l:inline",    // Enable cross-method optimizations (note: inlining requires -opt-inline-from): l:method,inline.
  "-opt-inline-from", // Patterns for classfile names from which to allow inlining,
  // Warning Settings
  "-Xfatal-warnings",      // Fail the compilation if there are any warnings.
  "-Ywarn-macros:after",   // Enable lint warnings on macro expansions.
  "-Ywarn-dead-code",      // Warn when dead code is identified.
  "-Ywarn-value-discard",  // Warn when non-Unit expression results are unused.
  "-Ywarn-numeric-widen",  // Warn when numerics are widened.
  "-Ywarn-unused:_",       // Enable or disable specific unused warnings
  "-Ywarn-extra-implicit", // Warn when more than one implicit parameter section is defined.
  "-Ywarn-self-implicit",  // Warn when an implicit resolves to an enclosing self-definition.
  "-Xlint:_"               // Enable or disable specific warnings
)
