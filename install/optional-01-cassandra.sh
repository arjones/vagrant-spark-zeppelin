#!/usr/bin/env bash

#
# Heavily inspired on https://github.com/docker-library/cassandra/blob/c7d43443c2e80ee9edd0814c8e8332781f7d93ae/2.1/Dockerfile
#

echo
echo
echo "Installing Cassandra"
export CASSANDRA_VERSION=2.1.14

apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 514A2AD631A57A16DD0047EC749D6EEC0353B12C
echo 'deb http://www.apache.org/dist/cassandra/debian 21x main' > /etc/apt/sources.list.d/cassandra.list

apt-get update && \
  apt-get install -y cassandra="${CASSANDRA_VERSION}"
