#!/usr/bin/env bash
#
# Copyright 2017 Gustavo Arjones (@arjones)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -e
export DEBIAN_FRONTEND=noninteractive

# Running Install Scripts
SCRIPTS=$(find /tmp/install/install-* -type f)

for SCRIPT in ${SCRIPTS}; do
  echo
  echo
  echo
  echo "--------------------------------------------"
  SCRIPT_NAME=$(basename ${SCRIPT})
  echo "Running ... ${SCRIPT_NAME}"

  "${SCRIPT}"

  echo "Finished ... ${SCRIPT_NAME}"
  echo "--------------------------------------------"
done

echo -e '\n\n\nHurrah! Install completed!\n\nGo to: http://localhost:8080\nUser: admin\nPass:admin\n\nMore information on how to use this box:\n http://arjon.es/2015/08/23/vagrant-spark-zeppelin-a-toolbox-to-the-data-analyst/.\n\nEnjoy it! @arjones'
