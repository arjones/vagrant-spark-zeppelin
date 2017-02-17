#!/usr/bin/env bash

echo "Cleaning up ..."
apt-get clean
rm -rf /var/lib/apt/lists/*

rm /home/vagrant/spark-2.0.2-bin-hadoop2.6.tgz
rm /home/vagrant/apache-maven-3.3.3-bin.tar.gz
rm /home/vagrant/zeppelin-0.6.2-bin-all.tgz
