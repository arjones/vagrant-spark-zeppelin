// Access the log files
val files = sc.textFile("/opt/dataset/pbj.access.log*")

// A regular Expression to parse the logs
val accessLogRE = """^(?<remoteip>[0-9\.]+) - - \[(?<datetime>.*?)\] "(?<verb>.*?) (?<url>.*?) HTTP\/1.1" (?<status>[0-9]+) (?<size>[0-9]+) "(?<referrer>.*?)" "(?<agent>.*?)" "(.*?)"$""".r

// Extract from each line the URL parameter
val pages = files.map { line =>
  accessLogRE.findFirstMatchIn(line).map(e => e.group(4))
}.flatMap(e => e)

// Convert in KeyValue RDD
val pageViews = pages.map((_, 1))
// Aggregate by Page URL
val pageViewsCounter = pageViews.reduceByKey(_ + _)

// Select Top 50 pages
val top = pageViewsCounter.map(_.swap).top(50)

// Print them
top.foreach(println)
