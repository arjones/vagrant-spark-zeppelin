#!/usr/bin/env bash

echo
echo
echo "Updating System"
sudo -u root bash << EOF
apt-get update
apt-get install -y git vim wget curl net-tools unzip python npm
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
export HADOOP_VERSION=2.4
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


# APACHE ZEPPELIN
export MAVEN_VERSION=3.3.1
export MAVEN_HOME=/usr/apache-maven-$MAVEN_VERSION

export ZEPPELIN_HOME=/usr/zeppelin
export ZEPPELIN_CONF_DIR=${ZEPPELIN_HOME}/conf
export ZEPPELIN_NOTEBOOK_DIR=${ZEPPELIN_HOME}/notebook
export ZEPPELIN_PORT=8080

sudo -u root bash << EOF
wget -c "http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
tar zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /usr/
ln -s ${MAVEN_HOME} /usr/maven

git clone https://github.com/apache/incubator-zeppelin.git ${ZEPPELIN_HOME}
# go to a commit I tested and builds correctly
git checkout d5ab911bf4419fa7c6f38945c6c8ad4946f8abf6

cd ${ZEPPELIN_HOME}
${MAVEN_HOME}/bin/mvn clean package -Pspark-1.4 -Dhadoop.version=2.4.0 -Phadoop-2.4 -DskipTests

cat > ${ZEPPELIN_HOME}/conf/zeppelin-env.sh <<CONF
export ZEPPELIN_MEM="-Xmx2048m"
export ZEPPELIN_JAVA_OPTS="-Dspark.home=/usr/spark"
CONF

echo "Copying Notebooks ..."
cp -vR /vagrant/notebook/* /usr/zeppelin/notebook/

ln -s ${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh /etc/init.d/
update-rc.d zeppelin-daemon.sh defaults

echo "Starting Zeppelin..."
/etc/init.d/zeppelin-daemon.sh start
EOF

echo
echo
echo "Finished ..."