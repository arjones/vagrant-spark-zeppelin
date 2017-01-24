#!/usr/bin/env bash

# APACHE ZEPPELIN
export MAVEN_VERSION=3.3.3
export MAVEN_HOME=/usr/apache-maven-$MAVEN_VERSION

export ZEPPELIN_HOME=/usr/zeppelin
export ZEPPELIN_CONF_DIR=${ZEPPELIN_HOME}/conf
export ZEPPELIN_NOTEBOOK_DIR=${ZEPPELIN_HOME}/notebook
export ZEPPELIN_PORT=8080

apt-get install -y git wget net-tools unzip python npm

# # Fixing Debian/Jessie 8.2 has changed "node" to "nodejs"
ln -fs /usr/bin/nodejs /usr/bin/node

# wget -c "http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
# tar zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /usr/
# ln -s ${MAVEN_HOME} /usr/maven

# git clone https://github.com/apache/incubator-zeppelin.git ${ZEPPELIN_HOME}

# cd ${ZEPPELIN_HOME}
# # go to a commit I tested and builds correctly


# ${MAVEN_HOME}/bin/mvn clean package -Pspark-1.6 -Dhadoop.version=2.6.0 -Phadoop-2.6 -DskipTests

# cat > ${ZEPPELIN_HOME}/conf/zeppelin-env.sh <<CONF
# export ZEPPELIN_MEM="-Xmx1024m"
# export ZEPPELIN_JAVA_OPTS="-Dspark.home=/usr/spark"
# CONF

# echo "Copying Notebooks ..."
# cp -vR /vagrant/notebook/* /usr/zeppelin/notebook/

# ln -s ${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh /etc/init.d/
# update-rc.d zeppelin-daemon.sh defaults

# echo "Starting Zeppelin..."
# /etc/init.d/zeppelin-daemon.sh start

# sudo echo 'export SPARK_HOME=/usr/spark' >> /usr/zeppelin/conf/zeppelin-env.sh

# echo "Restarting Zeppelin..."
# /etc/init.d/zeppelin-daemon.sh restart
