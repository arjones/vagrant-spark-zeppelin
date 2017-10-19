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
export ZEPPELIN_VERSION=0.7.3
export ZEPPELIN_HOME=/usr/zeppelin
export ZEPPELIN_CONF_DIR=${ZEPPELIN_HOME}/conf
export ZEPPELIN_NOTEBOOK_DIR=${ZEPPELIN_HOME}/notebook
export ZEPPELIN_PORT=8080

apt-get install -y wget

wget -c http://archive.apache.org/dist/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-netinst.tgz
tar zxvf zeppelin-${ZEPPELIN_VERSION}-bin-netinst.tgz -C /usr/
ln -s /usr/zeppelin-${ZEPPELIN_VERSION}-bin-netinst ${ZEPPELIN_HOME}

# Install interpreters
${ZEPPELIN_HOME}/bin/install-interpreter.sh --name md,python

cp -vpR /tmp/install/conf/shiro.ini ${ZEPPELIN_CONF_DIR}/shiro.ini
cp -vpR /tmp/install/conf/zeppelin-site.xml ${ZEPPELIN_CONF_DIR}/zeppelin-site.xml

cat > ${ZEPPELIN_HOME}/conf/zeppelin-env.sh <<CONF
export ZEPPELIN_MEM="-Xmx1024m"
export ZEPPELIN_JAVA_OPTS="-Dspark.home=/usr/spark"
export SPARK_HOME=/usr/spark
CONF

echo "Copying Notebooks ..."
cp -vR /vagrant/notebook/* /usr/zeppelin/notebook/

ln -s ${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh /etc/init.d/
update-rc.d zeppelin-daemon.sh defaults

echo "Starting Zeppelin..."
/etc/init.d/zeppelin-daemon.sh start
