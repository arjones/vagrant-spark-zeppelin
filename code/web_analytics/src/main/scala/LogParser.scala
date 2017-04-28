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
import java.net.URI

import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat

object LogParser {

  /**
   * Extract an LogRecord from the raw line
   * @param line
   * @return
   */
  def parse(line: String) = {
    def convertToDate(dateAsString: String): DateTime = {
      // 02/Jan/2003:02:06:41 -0700
      val dtf = DateTimeFormat.forPattern("dd/MMM/yyyy:HH:mm:ss Z")
      dtf.parseDateTime(dateAsString)
    }

    import scala.util.matching.Regex

    // 205.188.209.43 - - [09/Apr/2003:20:51:30 -0700] "GET /archive/2002/04/22/birthday.shtml HTTP/1.0" 200 12364 "http://www.google.com/search?hl=en&lr=&ie=ISO-8859-1&q=Julie+M.+Fidler" "Mozilla/4.0 (compatible; MSIE 6.0; AOL 8.0; Windows NT 5.1; .NET CLR 1.0.3705)"

    val pattern = new Regex( """^([0-9\.]+) - - \[(.*?)\] "(GET|HEAD|POST) (/[^ ]+) HTTP\/[0-2\.]+" ([0-9]+) ([0-9]+) "([^\\"]+)" "([^\\"]+)"$""",
      "remoteIP", "datetime", "method", "url", "responseCode", "size", "httpReferer", "agent")

    val result = pattern.findFirstMatchIn(line)

    if (result.isEmpty)
      None

    else {
      try {
        val m = result.get

        Some(
          LogRecord(
            clientId = "GAAGLE",
            remoteIP = m.group("remoteIP"),
            datetime = convertToDate(m.group("datetime")),
            method = m.group("method"),
            url = m.group("url"),
            responseCode = m.group("responseCode"),
            size = m.group("size").toLong,
            httpReferer = new URI(m.group("httpReferer")),
            agent = m.group("agent")
          )
        )

      } catch {
        case e: Exception => {
          // println(s"ERROR: ${e.getMessage}\n\t${line}\n")

          None
        }
      }
    }
  }

}
