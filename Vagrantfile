# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "debian/jessie64"
  config.vm.box_version = "8.1.0"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  #
  # APACHE ZEPPELIN
  config.vm.network "forwarded_port", guest: 8888, host: 8888
  #
  # APACHE SPARK UI
  config.vm.network "forwarded_port", guest: 4040, host: 4040
  config.vm.network "forwarded_port", guest: 4041, host: 4041
  # CASSANDRA
  # 7000: intra-node communication
  config.vm.network "forwarded_port", guest: 7000, host: 7000
  # 7001: TLS intra-node communication
  config.vm.network "forwarded_port", guest: 7001, host: 7001
  # 7199: JMX
  config.vm.network "forwarded_port", guest: 7199, host: 7199
  # 9042: CQL
  config.vm.network "forwarded_port", guest: 9042, host: 9042
  # 9160: thrift service
  config.vm.network "forwarded_port", guest: 9160, host: 9160

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--memory", "4096"]
  end

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./data", "/opt/dataset"
  config.vm.synced_folder "./code", "/home/vagrant/code"
  config.vm.synced_folder "./mavendeps", "/root/.m2"

  # View the documentation for the provider you're using for more
  # information on available options.
  config.vm.provision :shell, :path => "bootstrap.sh"

  # A message to show after vagrant up
  config.vm.post_up_message = "Good job !"
end
