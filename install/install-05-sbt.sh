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
export SBT_VERSION=0.13.15

wget -c https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz
tar zxvf sbt-${SBT_VERSION}.tgz -C /usr

echo "Including sbt on PATH"
cat > /etc/profile.d/sbt.sh <<EOF
export SBT_HOME="/usr/sbt"
export PATH=$PATH:\${SBT_HOME}/bin/
EOF
