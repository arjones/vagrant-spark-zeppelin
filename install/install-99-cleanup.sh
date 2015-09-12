#!/usr/bin/env bash

echo "Cleaning up ..."
apt-get clean
#rm -rf /var/lib/apt/lists/*

rm /home/vagrant/spark-1.4.1-bin-hadoop2.4.tgz
rm /home/vagrant/apache-maven-3.3.1-bin.tar.gz
