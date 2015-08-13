val files = sc.textFile("/opt/dataset/pbj.access.log*")

val accessLogRE = """^(?<remoteip>[0-9\.]+) - - \[(?<datetime>.*?)\] "(?<verb>.*?) (?<url>.*?) HTTP\/1.1" (?<status>[0-9]+) (?<size>[0-9]+) "(?<referrer>.*?)" "(?<agent>.*?)" "(.*?)"$""".r

val pages = files.map { line =>
  accessLogRE.findFirstMatchIn(line).map(e => e.group(4))
}.flatMap(e => e)

val pageViews = pages.filter(u => u).map((_, 1))
val pageViewsCounter = pageViews.reduceByKey(_ + _)

val top = pageViewsCounter.map(_.swap).top(50)
top.foreach(println)