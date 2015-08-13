#Apache Spark with Vagrant

This is a simple Apache Spark installation based on Debian [debian/jessie64](https://atlas.hashicorp.com/debian/boxes/jessie64)
`bootstrap.sh` was inspired by [gettyimages/docker-spark](https://github.com/gettyimages/docker-spark)

###Connect to Spark Shell
```
vagrant ssh
vagrant@debian-jessie:~$ spark-shell
```

###Run some examples
[Check some examples here](code/)