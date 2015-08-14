// Access the log files
val files = sc.textFile("/opt/dataset/star_wars_kid.log")

// A regular Expression to parse the logs
val accessLogRE = """^(?<remoteip>[0-9\.]+) - - \[(?<datetime>.*?)\] "(?<verb>.*?) (?<url>.*?) HTTP\/1.1" (?<status>[0-9]+) (?<size>[0-9]+) "(?<referrer>.*?)" "(?<agent>.*?)" "(.*?)"$""".r

// Extract from each line the URL parameter
val pages = files.map { line =>
  accessLogRE.findFirstMatchIn(line).map(e => e.group(4))
}.flatMap(e => e)

def isValidPage(pageUrl: String) = {
  val url = """^/[a-zA-Z0-9\-]+/$""".r
  url.findFirstIn(pageUrl).isDefined
}

// Filter pages that aren't interesting
val validPages = pages.filter(isValidPage)

// Convert in KeyValue RDD
val pageViews = validPages.map((_, 1))
// Aggregate by Page URL
val pageViewsCounter = pageViews.reduceByKey(_ + _)

// Select Top 50 pages
val top = pageViewsCounter.map(_.swap).top(50)

// Print them
top.foreach(println)
