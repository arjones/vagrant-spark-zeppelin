import org.apache.spark.{SparkConf, SparkContext}

object LogAnalyzer {

  def main(args: Array[String]) {

    // Configure the SparkContext with Cassandra
    //
    val conf = new SparkConf().
      set("spark.cassandra.connection.host", "127.0.0.1").
      setAppName("LogAnalyzer")

    // Create a new Spark Context
    val sc = new SparkContext(conf)

    if (args.length == 0) {
      println(
        s"""
           |Error: Missing file path. Ej: /opt/dataset/http_access*
        """.stripMargin)
      System.exit(1)
    }

    val file = sc.textFile(args(0))
    val logRecordRDD = new ParseRawDataPipeline().run(file)

    // Calculate PageViews
    new PageViewPipeline().run(logRecordRDD)

    // calcular paginas más visitadas,
    new TopURLsPipeline().run(logRecordRDD)

    //
    // origen de los usuarios,
    new TopOriginPipeline().run(logRecordRDD)

    // transferencias,
    new BytesTransferredPipeline().run(logRecordRDD)

  }

}
