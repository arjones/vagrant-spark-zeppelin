#!/usr/bin/env bash

# APACHE SPARK
export SPARK_VERSION=2.0.2
export HADOOP_VERSION=2.6
export SPARK_PACKAGE=$SPARK_VERSION-bin-hadoop$HADOOP_VERSION
export SPARK_HOME=/usr/spark-$SPARK_PACKAGE
export PATH=$PATH:$SPARK_HOME/bin
echo
echo
echo "Installing Apache Spark ${SPARK_VERSION}"
wget -c "http://d3kbcqa49mib13.cloudfront.net/spark-$SPARK_PACKAGE.tgz"

tar zxvf spark-${SPARK_PACKAGE}.tgz -C /usr/
rm -f /usr/spark
ln -s $SPARK_HOME /usr/spark

#
# Reduce Login NOISE on Spark Shell
sed 's/INFO/WARN/g' /usr/spark/conf/log4j.properties.template > /usr/spark/conf/log4j.properties

echo "Including Spark on PATH"
echo 'export PATH=$PATH:/usr/spark/bin/' > /etc/profile.d/spark.sh
