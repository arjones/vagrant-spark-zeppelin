import org.apache.spark.rdd.RDD

/**
 * Created by arjones on 9/11/15.
 */
class BytesTransferredPipeline extends DummyLog {

  def run(input: RDD[LogRecord]) {

    val transfer = input.map { log =>
      val bytes = TimeSerieRecord(log.clientId, log.datetime.toString("yyyy-MM-dd HH:00:00"), log.size)
      (bytes.key, bytes)
    }

    // Aggregate all PageViews that happen at same client_id AND same hour
    //
    val bytesTransferred = transfer.
      reduceByKey(_ + _).
      map(rec => rec._2)

    // save the results on Cassandra Table "page_views"
    //
    import com.datastax.spark.connector._
    bytesTransferred.saveToCassandra("analytics", "bytes_transferred")
  }

}
