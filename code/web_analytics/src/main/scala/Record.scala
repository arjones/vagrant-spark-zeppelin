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

case class LogRecord(clientId: String, remoteIP: String, datetime: org.joda.time.DateTime, method: String,
                     url: String, responseCode: String, size: Long, httpReferer: java.net.URI, agent: String)

case class AggregationKey(clientId: String, eventTimestamp: String)

case class TimeSerieRecord(clientId: String, eventTimestamp: String, frequency: Long = 1) {
  val key = AggregationKey(clientId, eventTimestamp)

  def +(other: TimeSerieRecord): TimeSerieRecord = {
    assert(other.key.clientId == this.key.clientId, s"Expecting clientId to be ${this.key.clientId} and received ${other.key.clientId} instead")
    assert(other.key.eventTimestamp == this.key.eventTimestamp, s"Expecting eventTimestamp to be ${this.key.eventTimestamp} and received ${other.key.eventTimestamp} instead")

    TimeSerieRecord(this.clientId, this.eventTimestamp, this.frequency + other.frequency)
  }
}

case class ListKey(clientId: String, eventTimestamp: String, item: String)

case class ListRecord(clientId: String, eventTimestamp: String, item: String, frequency: Long = 1) {
  val key = ListKey(clientId, eventTimestamp, item)

  def +(other: ListRecord): ListRecord = {
    assert(other.key.clientId == this.key.clientId, s"Expecting clientId to be ${this.key.clientId} and received ${other.key.clientId} instead")
    assert(other.key.eventTimestamp == this.key.eventTimestamp, s"Expecting eventTimestamp to be ${this.key.eventTimestamp} and received ${other.key.eventTimestamp} instead")
    assert(other.key.item == this.key.item, s"Expecting item to be ${this.key.item} and received ${other.key.item} instead")

    ListRecord(this.clientId, this.eventTimestamp, this.item, this.frequency + other.frequency)
  }
}
