import org.apache.spark.rdd.RDD

/**
 * Created by arjones on 9/11/15.
 */
class ParseRawDataPipeline extends DummyLog {

  def run(input: RDD[String]): RDD[LogRecord] = {
    input.flatMap(line => LogParser.parse(line)).cache
  }

}
