#Apache Spark with Vagrant

This is a simple Apache Spark installation based on Debian [debian/jessie64](https://atlas.hashicorp.com/debian/boxes/jessie64)
`bootstrap.sh` was inspired by [gettyimages/docker-spark](https://github.com/gettyimages/docker-spark)

###Create the VM
Just run `vagrant up`, it will take **10+ minutes** to download everything, go get a coffee!

###Connect to Spark Shell
```
vagrant ssh
vagrant@debian-jessie:~$ spark-shell
```

###Run some examples
[Check some examples here](code/)


###Examples Datasets
http://waxy.org/2008/05/star_wars_kid_the_data_dump/

