import sbt._
import Keys._

name         := "joinus-devops-service"
organization := "com.softwaremill"
version      := "1.0.0-SNAPSHOT"
scalaVersion := "2.13.14"
mainClass    := Some("com.softwaremill.Main")

libraryDependencies ++= {
  val AkkaVersion         = "2.8.6"
  val AkkaHttpVersion     = "10.5.3"
  val Json4sVersion       = "4.0.7"
  val ScalaLoggingVersion = "3.9.5"
  val Slf4jVersion        = "2.0.16"
  val ScalatestVersion    = "3.2.19"
  Seq(
    "com.typesafe.akka"          %% "akka-actor"    % AkkaVersion,
    "com.typesafe.akka"          %% "akka-stream"   % AkkaVersion,
    "com.typesafe.akka"          %% "akka-http"     % AkkaHttpVersion,
    "com.typesafe.scala-logging" %% "scala-logging" % ScalaLoggingVersion,
    "org.json4s"                 %% "json4s-native" % Json4sVersion,
    "com.typesafe.akka"          %% "akka-slf4j"    % AkkaVersion,
    "org.slf4j"                   % "slf4j-simple"  % Slf4jVersion,
    "org.scalatest"              %% "scalatest"     % ScalatestVersion % "test"
  )
}

assembly / assemblyMergeStrategy := {
  case PathList("module-info.class")               => MergeStrategy.last
  case path if path.endsWith("/module-info.class") => MergeStrategy.last
  case x =>
    val oldStrategy = (assembly / assemblyMergeStrategy).value
    oldStrategy(x)
}
