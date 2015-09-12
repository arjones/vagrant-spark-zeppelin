import org.apache.spark.rdd.RDD

/**
 * Created by arjones on 9/11/15.
 */
class TopOriginPipeline extends DummyLog {

  def run(input: RDD[LogRecord]): Unit = {

    val ips = input.
      map { log =>
      val ip = ListRecord(log.clientId, log.datetime.toString("yyyy-MM-dd"), IP2CountryUtil.dummyIPtoCountry(log.remoteIP))
      (ip.key, ip)
    }

    val ipCounter = ips.
      reduceByKey(_ + _).
      map(rec => rec._2).
      filter(ip => ip.frequency > 2)

//    ipCounter.take(100).foreach(println)

    import com.datastax.spark.connector._
    ipCounter.saveToCassandra("analytics", "top_countries")
  }
}
