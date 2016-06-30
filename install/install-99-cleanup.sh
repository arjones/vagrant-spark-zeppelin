#!/usr/bin/env bash

echo "Cleaning up ..."
apt-get clean
rm -rf /var/lib/apt/lists/*

rm /home/vagrant/spark-1.6.1-bin-hadoop2.6.tgz
rm /home/vagrant/apache-maven-3.3.1-bin.tar.gz
