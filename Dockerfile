FROM ubuntu:16.04

EXPOSE 8080 4040 4041 7000 7001 7199 9042 9160

RUN mkdir -p /opt/dataset /root/samples /tmp/install

ADD data/* /opt/dataset/
ADD code/* /root/samples/
ADD notebook/* /usr/zeppelin/notebook/
ADD install/* /tmp/install/

RUN /tmp/install/bootstrap.sh
