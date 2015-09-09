#!/usr/bin/env bash

# APACHE ZEPPELIN
export MAVEN_VERSION=3.3.1
export MAVEN_HOME=/usr/apache-maven-$MAVEN_VERSION

export ZEPPELIN_HOME=/usr/zeppelin
export ZEPPELIN_CONF_DIR=${ZEPPELIN_HOME}/conf
export ZEPPELIN_NOTEBOOK_DIR=${ZEPPELIN_HOME}/notebook
export ZEPPELIN_PORT=8080

#apt-get update
apt-get install -y git wget net-tools unzip python npm

wget -c "http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
tar zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /usr/
ln -s ${MAVEN_HOME} /usr/maven

git clone https://github.com/apache/incubator-zeppelin.git ${ZEPPELIN_HOME}

cd ${ZEPPELIN_HOME}
# go to a commit I tested and builds correctly
git checkout d5ab911bf4419fa7c6f38945c6c8ad4946f8abf6

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
