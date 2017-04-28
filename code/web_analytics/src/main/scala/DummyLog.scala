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
/**
 * Created by arjones on 9/12/15.
 */
trait DummyLog {
  println("\n" * 3)
  println("=" * 35)
  println(s"Entering class ${this.getClass.getSimpleName}")
}
