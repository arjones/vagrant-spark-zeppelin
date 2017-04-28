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
# APACHE SPARK
export SPARK_VERSION=2.0.2
export HADOOP_VERSION=2.7
export SPARK_PACKAGE=$SPARK_VERSION-bin-hadoop$HADOOP_VERSION
export SPARK_HOME=/usr/spark-$SPARK_PACKAGE
export PATH=$PATH:$SPARK_HOME/bin
echo
echo
echo "Installing Apache Spark ${SPARK_VERSION} with Hadoop ${HADOOP_VERSION}"
wget -c "http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_PACKAGE}.tgz"

tar zxvf spark-${SPARK_PACKAGE}.tgz -C /usr/
rm -f /usr/spark
ln -s $SPARK_HOME /usr/spark

#
# Reduce Login NOISE on Spark Shell
sed 's/INFO/ERROR/g' /usr/spark/conf/log4j.properties.template > /usr/spark/conf/log4j.properties

echo "Including Spark on PATH"
echo 'export PATH=$PATH:/usr/spark/bin/' > /etc/profile.d/spark.sh
