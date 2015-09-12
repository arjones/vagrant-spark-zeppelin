import sbt.Keys._

name := "web_analytics"

version := "1.0"

scalaVersion := "2.10.5"

scalacOptions := Seq("-deprecation", "-unchecked", "-feature")

libraryDependencies ++= Seq(
  "joda-time" % "joda-time" % "2.7",
  "org.joda" % "joda-convert" % "1.6",
  "com.datastax.spark" %% "spark-cassandra-connector" % "1.4.0-M3",
  "org.apache.spark" %% "spark-core" % "1.4.1" % "provided",
  "org.apache.spark" %% "spark-sql" % "1.4.1" % "provided"
)

assemblyJarName in assembly := s"${name.value}-${version.value}.jar"

assemblyMergeStrategy in assembly := {
  case PathList("META-INF", "MANIFEST.MF") => MergeStrategy.discard
  case _ => MergeStrategy.first
}