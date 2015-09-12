
object IP2CountryUtil {
  /**
   * A TOTALLY DUMMY function to map IP to Countries
   * @param ip
   * @return
   */
  def dummyIPtoCountry(ip: String) = {

    ip.split("\\.")(0).toInt match {

      case n: Int if n >= 0 && n < 100 => "US"
      case n: Int if n >= 100 && n < 180 => "UK"
      case n: Int if n >= 180 && n < 190 => "MX"
      case n: Int if n >= 190 && n < 210 => "BR"
      case n: Int if n >= 210 && n < 220 => "AR"
      case n: Int if n >= 220 && n < 230 => "PY"
      case n: Int if n >= 230 && n < 240 => "UK"
      case n: Int if n >= 240 && n < 255 => "CA"
      case _ => "UNKNOWN"

    }

  }

}
