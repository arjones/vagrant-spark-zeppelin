# Practice : tweak a Zeppelin environment and test Spark

This is a fork from [arjones/vagrant-spark-zeppelin](https://github.com/arjones/vagrant-spark-zeppelin), that we are going to use for educational purposes.

It provides a Vagrantfile which installs a debian virtual machine containing:

* Apache Spark 1.6.1
* Apache Zeppelin from master
* Apache Maven 3.3.3

## Prerequisites

* [Git](https://git-scm.com/)
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)  >= 1.5

<hr>
# Exercise

A step by step guide is available with the blog post: [Vagrant + Spark + Zeppelin a Toolbox to the Data Analyst](http://arjon.es/2015/08/23/vagrant-spark-zeppelin-a-toolbox-to-the-data-analyst/). This will only serve as a guideline, we are going to modify the environment a bit.

Verify your vagrant version:

```sh
$ vagrant version
Installed Version: 1.8.4
Latest Version: 1.9.1
```

Thourough this README, you will need to validate the definitions of done described at the end of each point.

#### 1. Fork my repository

##### a. Create a Github account
Go and create an account on Github. Though you may use the username you want, don't forget to put your full name in your profile so I know who you are when you merge your work into mine.

_Done : You should be able to access your Github account._

##### b. Fork my project
First thing to do is **fork** my project. You don't have the rights to push on my project, so what you will do is create a copy of the project, create a branch on your copy, work on that branch, and then create a merge request of your branch to my build. I will be able to review your work and even comment through that merge request. [More details](https://help.github.com/articles/working-with-forks/).

_Done : You have a new repository in your Github account which consists of a copy of my original repository._

#####c. Clone your fork to your local machine

When you have forked the project to your Github account, use the `git clone` command to fetch it.

_Done : You can access your project on your local machine named vagrant-spark-zeppelin._

#####d. Optional : launch the download of the debian/jessie virtual machine

The process takes a bit of time so launch `$ vagrant up` to begin the download.

#### 2. First steps with Git

You are going to create your first branch, commit a personal message on this README, merge it back to your master branch and push your work back into your Github repo.

Don't forget to `cd vagrant-spark-zeppelin`.

Don't worry, experiment, test things, read the documentation. If anything goes wrong, just delete the vagrant-spark-zeppelin and pull it again from Github.

#####a. Work on a branch called "edit_README"

_Done : You have a branch "edit\_README" on your local machine and you should be pointing on it. I should see the following output on a git branch command_

```sh
$ git branch
* edit_README
  master
```

#####b. Commit a personal message to the README in your branch

Please add a message between the following lines:

<hr>
PERSONAL MESSAGE
<hr>

then add and commit the file to your "edit_README" branch.

_Done : you have a new commit in your branch_

#####c. Merge "edit_README" into master

_Done : your personal message commit is in master, your "edit\_README" no longer exists_

#####d. Push your local master branch to your remote repo

_Done : your personal message appears on the README.md on Github =)_

####Conclusion

This is the very basic Git workflow you need to get used to: create a feature on a new branch, work on it and when it is finished, merge it back.

Now, you have the rights to merge your feature branch into your master branch, but you can't merge your feature branch into my master branch thagt easily. For that you need to create a **pull request**, that is ask me to review your feature branch and merge it into my master branch if I think it is useful.

We will do that at the end, but do take note that it will be much easier for me to review your work through pull requests rather than going into each of your repositories.

#### 3. Tweaking the Vagrantfile

The normal command to build the virtual environment would be `$ vagrant up`. Now there is a problem with this build, as specified in the blog: _Depending of your internet speed it can take up to 1 hour to build, it takes so long, because there is no binary distribution of Zeppelin and we have to download all dependencies and build it from sources. Be patient, I’m sure you will enjoy the final result._

There is actually a binary distribution available today for Zeppelin [here](http://zeppelin.apache.org/download.html). So we need to edit the installation scripts. I have done most of the work so it is not too much of a hassle.

#####a. Understand the virtual machine build process

Since this is a vagrant environment, when you use `$ vagrant up` it reads `Vagrantfile` first. Now try to guess by following along the lines of the build.

_Done : if you found the answer, the script to edit should be obvious._

#####b. Tweak the install script to have the binary Zeppelin 0.6.2 installed

First, create a new branch (name it as you like). New feature = new branch, always, so your master branch is ALWAYS stable.

If you have already launched `$ vagrant up`, you should have a running zeppelin virtual machine displayed in VirtualBox. The command `$ vagrant destroy` should remove it. With those two commands, you can relaunch your virtual machine as you wish (you also have `$ vagrant halt` if you only want to stop the virtual machine but not destroy it)

_Done : Try to edit the necessary code to get a vagrant virtual machine with Zeppelin 0.6.2._

#####c. Push back to Github

_Done: merge your branch back into master when you are ok with it, and push to your remote repository._

#### Conclusion

You should now have a working Zeppelin in a virtual machine that you can destroy and recreate as you wish. You can even add additional components through the different install scripts.

To hit Apache Zeppelin, http://localhost:8080.

#### 4. Editing Spark code

Time to fire up Zeppelin.

#### 5. Pull request

You can now ask to merge your work to my repository. With a pull request