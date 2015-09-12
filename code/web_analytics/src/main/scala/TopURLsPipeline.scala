import org.apache.spark.rdd.RDD

/**
 * Created by arjones on 9/11/15.
 */
class TopURLsPipeline extends DummyLog {

  def run(input: RDD[LogRecord]): Unit = {

    val urls = input.
      map { log =>
      val url = ListRecord(log.clientId, log.datetime.toString("yyyy-MM-dd HH:00:00"), log.url)
      (url.key, url)
    }

    val urlsCounter = urls.
      reduceByKey(_ + _).
      map(rec => rec._2)

    import com.datastax.spark.connector._
    urlsCounter.saveToCassandra("analytics", "top_urls")
  }

}
