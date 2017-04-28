/**
* Copyright 2017 Gustavo Arjones (@arjones)
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

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
