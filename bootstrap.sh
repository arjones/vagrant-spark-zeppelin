#!/usr/bin/env bash

echo
echo
echo "Updating System"
sudo -u root bash << EOF
apt-get update
apt-get install -y vim wget curl net-tools unzip python
EOF

# JAVA
export JAVA_HOME=/usr/jdk1.8.0_31
export PATH=$PATH:$JAVA_HOME/bin

echo
echo
echo "Installing Java"
sudo -u root bash << EOF
echo > /etc/apt/sources.list.d/webupd8team-java.list
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
apt-get update

echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
export DEBIAN_FRONTEND=noninteractive 
apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default

sudo apt-get clean
rm -rf /var/lib/apt/lists/*
EOF
java -version

# APACHE SPARK
export SPARK_VERSION=1.4.1
export HADOOP_VERSION=2.6
export SPARK_PACKAGE=$SPARK_VERSION-bin-hadoop$HADOOP_VERSION
export SPARK_HOME=/usr/spark-$SPARK_PACKAGE
export PATH=$PATH:$SPARK_HOME/bin
echo
echo
echo "Installing Apache Spark ${SPARK_VERSION}"
wget -c "http://mirrors.ibiblio.org/apache/spark/spark-$SPARK_VERSION/spark-$SPARK_PACKAGE.tgz"
sudo -u root bash << EOF
tar zxvf spark-$SPARK_PACKAGE.tgz -C /usr/
ln -s $SPARK_HOME /usr/spark
sed 's/INFO/WARN/g' /usr/spark/conf/log4j.properties.template > /usr/spark/conf/log4j.properties

echo "Including Spark on PATH"
echo 'export PATH=$PATH:/usr/spark/bin/' > /etc/profile.d/spark.sh
EOF

echo
echo
echo "Finished ..."