#!/usr/bin/env bash

# APACHE ZEPPELIN
export MAVEN_VERSION=3.3.3
export MAVEN_HOME=/usr/apache-maven-$MAVEN_VERSION

export ZEPPELIN_VERSION=0.6.2
export ZEPPELIN_PACKAGE=$ZEPPELIN_VERSION-bin-all
export ZEPPELIN_HOME=/usr/zeppelin-0.6.2-bin-all
export ZEPPELIN_CONF_DIR=${ZEPPELIN_HOME}/conf
export ZEPPELIN_NOTEBOOK_DIR=${ZEPPELIN_HOME}/notebook

apt-get install -y git wget net-tools unzip python npm

# # Fixing Debian/Jessie 8.2 has changed "node" to "nodejs"
ln -fs /usr/bin/nodejs /usr/bin/node

wget -c "http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
tar zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /usr/
ln -s ${MAVEN_HOME} /usr/maven

wget -c "http://archive.apache.org/dist/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_PACKAGE}.tgz"
tar zxvf zeppelin-${ZEPPELIN_PACKAGE}.tgz -C /usr/
ln -s ${ZEPPELIN_HOME} /usr/zeppelin

cd ${ZEPPELIN_HOME}

cat > ${ZEPPELIN_HOME}/conf/zeppelin-env.sh <<CONF
export ZEPPELIN_MEM="-Xmx1024m"
export ZEPPELIN_JAVA_OPTS="-Dspark.home=/usr/spark"
export ZEPPELIN_NOTEBOOK_DIR="/vagrant/notebook/"
export ZEPPELIN_PORT="8888"
CONF

ln -s ${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh /etc/init.d/
update-rc.d zeppelin-daemon.sh defaults

echo "Starting Zeppelin..."
/etc/init.d/zeppelin-daemon.sh start

sudo echo 'export SPARK_HOME=/usr/spark' >> /usr/zeppelin/conf/zeppelin-env.sh

echo "Restarting Zeppelin..."
/etc/init.d/zeppelin-daemon.sh restart
