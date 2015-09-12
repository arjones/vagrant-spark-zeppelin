import org.apache.spark.rdd.RDD

/**
 * Created by arjones on 9/11/15.
 */
class PageViewPipeline extends DummyLog {

  def run(input: RDD[LogRecord]) {

    // Take each record, extracts the ROUNDED HOUR of the event
    // so we can count together all PV that happened same hour
    // Create a `PairRDD` to apply with the Function `reduceByKey`
    // The resulting object is:
    //
    // (("gaagle", "2003-04-30 15:00:00"), ("gaagle", "2003-04-30 15:00:00", 1))
    //
    val pageViews = input.map { log =>
      val pv = TimeSerieRecord(log.clientId, log.datetime.toString("yyyy-MM-dd HH:00:00"))
      (pv.key, pv)
    }

    // Aggregate all PageViews that happen at same client_id AND same hour
    //
    val pageViewsCounter = pageViews.
      reduceByKey(_ + _).
      map(rec => rec._2)

    // save the results on Cassandra Table "page_views"
    //
    import com.datastax.spark.connector._
    pageViewsCounter.saveToCassandra("analytics", "page_views")
  }

}
