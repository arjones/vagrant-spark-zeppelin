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

echo
echo
echo "Installing Java"

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
apt-get update

echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

export DEBIAN_FRONTEND=noninteractive
apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default

echo "Including Java on PATH"
cat > /etc/profile.d/java.sh <<EOF
export JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre/
export PATH=$PATH:$JAVA_HOME/bin
EOF

java -version
