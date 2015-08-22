// spark-shell --packages 'joda-time:joda-time:2.8.2,org.joda:joda-convert:1.7'
//
import java.net.URI

import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat

// A class to hold one line of log
case class AccessLog(remoteIP: String, datetime: org.joda.time.DateTime, method: String, url: java.net.URI,
  responseCode: String, size: Long, httpReferer: java.net.URI, agent: String)

// Parse the line
def parseLog(line: String): Option[AccessLog] = {
  def convertToDate(dateAsString: String): DateTime = {
    // 02/Jan/2003:02:06:41 -0700
    val dtf = DateTimeFormat.forPattern("dd/MMM/yyyy:HH:mm:ss Z")
    dtf.parseDateTime(dateAsString)
  }

  import scala.util.matching.Regex
  val pattern = new Regex( """^([0-9\.]+) - - \[(.*?)\] "(.*?) (.*?) HTTP\/.*?" ([0-9]+) ([0-9]+) "(.*?)" "(.*?)"$""",
    "remoteIP", "datetime", "method", "url", "responseCode", "size", "httpReferer", "agent")

  val result = pattern.findFirstMatchIn(line)

  if (result.isEmpty)
    None

  else {
    try {
      val m = result.get

      Some(
        AccessLog(
          remoteIP = m.group("remoteIP"),
          datetime = convertToDate(m.group("datetime")),
          method = m.group("method"),
          url = new URI(m.group("url")),
          responseCode = m.group("responseCode"),
          size = m.group("size").toLong,
          httpReferer = new URI(m.group("httpReferer")),
          agent = m.group("agent")
        )
      )

    } catch {
      case e: Exception => None
    }
  }
}

val logs = sc.textFile("/opt/dataset/*.log.gz")

// Extract from each line the URL parameter
val logRecords = logs.map(parseLog).flatMap(e => e)

// Convert in KeyValue RDD
val pageViews = pages.map((_, 1))
// Aggregate by Page URL
val pageViewsCounter = pageViews.reduceByKey(_ + _)

// Select Top 50 pages
val top = pageViewsCounter.map(_.swap).top(50)

// Print them
top.foreach(println)




