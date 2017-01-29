# Practice : tweak a Zeppelin environment and test Spark

This is a fork from [arjones/vagrant-spark-zeppelin](https://github.com/arjones/vagrant-spark-zeppelin), that we are going to use for educational purposes.

It provides a Vagrantfile which installs a debian virtual machine containing:

* Apache Spark 1.6.1
* Apache Zeppelin 0.6.2
* Apache Maven 3.3.3

## Prerequisites

* [Git](https://git-scm.com/)
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)  >= 1.5

<hr>

# Exercise

For more information on the project we have forked and modified for convenience, you can check this blog post: [Vagrant + Spark + Zeppelin a Toolbox to the Data Analyst](http://arjon.es/2015/08/23/vagrant-spark-zeppelin-a-toolbox-to-the-data-analyst/).

Thourough this README, you will need to validate the definitions of done described at the end of each point.

With this, you should be able to launch a Zeppelin environment through Vagrant with `vagrant up` then hit `http://localhost:8888`. The `notebook` folder is synced with the created VM, so any changes to Zeppelin notebooks should be visible locally and can be committed to your Github project.

#### 1. Fork my repository

##### a. Create a Github account
Go to https://github.com/ and create an account. 

Though you may use the username you want, don't forget to put your full name in your profile so I know who you are when you merge your work into mine. Do not forget 

_Done : You should be able to access your Github account._

##### b. Fork my project
First thing to do is **fork** my project. 

You don't have the rights to push your modifications to my Github project, so what you will do is create a copy of the project. After that you can create a branch on your copy, work on that branch, and then create a merge request of your branch to my master branch. I will be able to review your work and even comment through that merge request. [More details](https://help.github.com/articles/working-with-forks/).

You will find the **fork** button on my Github project.

_Done : You have a new repository in your Github account which consists of a copy of my original repository._

#####c. Clone your fork to your local machine
When you have forked the project to your Github account, you need to download it locally. Use the `$ git clone https://github.com/<username>/vagrant-spark-zeppelin.git` command to fetch it.

_Done : You can access your project on your local machine named vagrant-spark-zeppelin._

#####d. Edit your local Git username & email

You will need to configure your username and email address on your Git project configuration.

```sh
$ git config user.name "John Doe"
$ git config user.email johndoe@example.com
```

_Done : `$ git config -l` should display your username and email_

#####e. Launch the download of the debian/jessie64 virtual machine

In the Vagrantfile, you can find the line `config.vm.box = "debian/jessie64"` which specifies the base box used for our Zeppelin environment.

The download of the box takes some time, so let's pre-download it: 

`$ vagrant box add debian/jessie64`

_Done : `$ vagrant box list` should display debian/jessie64_

#### 2. First steps with Git

You are going to create your first branch, commit a personal message on this README, merge it back to your master branch and push your work back into your Github repo.

Don't forget to work in the project you just cloned: `$ cd vagrant-spark-zeppelin`.

Don't worry, experiment, test things, read the documentation. If anything goes wrong, just delete the vagrant-spark-zeppelin and pull it again from Github.

#####a. Work on a branch called "edit_README"

`$ git branch new_branch` will create the branch _new branch_.

`$ git checkout new_branch` will get you on the branch _new branch_.

`$ git checkout -b new_branch` will create the branch _new branch_ and directly switch to it.

_Done : You have a branch "edit\_README" on your local machine and you should be pointing on it. I should see the following output on a git branch command_

```sh
$ git branch
* edit_README
  master
```

#####b. Commit a personal message to the README in your branch

Add a message between the following lines:

<hr>
PERSONAL MESSAGE
<hr>

With `$ git status` you can check the status of your Git repository.

With `$ git diff README.md` you can see modifications made to README.md compared to the HEAD pointer.

When you are done with modificationd, add them (`$ git add README.md`) and then commit your changes (`$ git commit -m "edited the README"`). Because you are on the _edit\_README_ branch, this should add the commit to this branch.

_Done : you have a new commit in your branch. Check `git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all` for a pretty print of your Git history_

#####c. Merge "edit_README" into master

Now that you have made modifications that you committed on branch _edit\_README_, let's merge that branch back into _master_. By doing this, your modifications should appear on _master_.

To do that, go back on master `$ git checkout master` and then merge your  _edit\_README_ branch `$ git merge edit_README`.

After that, it should be safe to delete your feature branch with `$ git branch -d edit_README`

_Done : your personal message commit is in master, your "edit\_README" no longer exists_

#####d. Push your local master branch to your remote repo

Because you have cloned the project, you should already have a configured remote called origin.

```sh
$ git remote -v
origin  https://github.com/<username>/vagrant-spark-zeppelin.git (fetch)
origin  https://github.com/<username>/vagrant-spark-zeppelin.git (push)
```

To push your local master branch to Github, we use the `git push <remote> <branch>` command. Remote is the remote server you want to push to, and branch the local branch you want to push.

`$ git push origin master`

NB: You can also push branchese that do not exist on the remote repository, but you will need to specify that you create a branch on the remote and that you need to track it : `$ git push -u origin <branch>`

_Done : your personal message appears on the README.md on Github =)_

####Conclusion

This is the very basic Git workflow you need to get used to: create a feature on a new branch, work on it and when it is finished, merge it back.

Now, you have the rights to merge your feature branch into your master branch, but you can't merge your feature branch into my master branch thagt easily. For that you need to create a **pull request**, that is ask me to review your feature branch and merge it into my master branch if I think it is useful.

We will do that at the end, but do take note that it will be much easier for me to review your work through pull requests rather than going into each of your repositories.

#### 3. Tweaking the Vagrantfile

The normal command to build the virtual environment would be `$ vagrant up`. Now there is a problem with this build, as specified in the blog: _Depending of your internet speed it can take up to 1 hour to build, it takes so long, because there is no binary distribution of Zeppelin and we have to download all dependencies and build it from sources. Be patient, I’m sure you will enjoy the final result._

There is actually a binary distribution available today for Zeppelin [here](http://zeppelin.apache.org/download.html). So we edited the installation scripts. I have done most of the work so it is not too much of a hassle.

#####a. Understand the virtual machine build process

Since this is a vagrant environment, when you use `$ vagrant up` it reads the `Vagrantfile` first. Now try to guess how the virtual machine is built by following along the lines of the Vagrantfile.

_Done : if you found the answer, the script to edit should be obvious._

#####b. Tweak the install script to have the binary Zeppelin 0.6.2 installed

First, create a new branch (name it as you like). New feature = new branch, always, so your master branch is ALWAYS stable.

If you have already launched `$ vagrant up`, you should have a running zeppelin virtual machine displayed in VirtualBox. The command `$ vagrant destroy` should remove it. With those two commands, you can relaunch your virtual machine as you wish (you also have `$ vagrant halt` if you only want to stop the virtual machine but not destroy it)

_Done : Try to edit the necessary code to get a vagrant virtual machine with Zeppelin 0.6.2._

#####c. Push back to Github

_Done: merge your branch back into master when you are ok with it, and push to your remote repository._

#### Conclusion

You should now have a working Zeppelin in a virtual machine that you can destroy and recreate as you wish. You can even add additional components through the different install scripts.

To hit Apache Zeppelin, http://localhost:8888.

#### 4. Editing Spark code

Time to fire up Zeppelin. You will see a bunch of notebooks already available. We will pursue the practical on the **Practice** notebook.

_Done: Solve all of the exercises in the notebook_

#### 5. Pull request

You can now ask to merge your work to my repository. With a pull request, it will be easier for me to study and comment on your code.

# Applicative project

If you want to check the data for the applicative project:

* Forest cover: https://archive.ics.uci.edu/ml/machine-learning-databases/covtype/
* Network traffic: http://kdd.ics.uci.edu/databases/kddcup99/kddcup99.html
* Music recommendation: http://www-etud.iro.umontreal.ca/~bergstrj/audioscrobbler_data.html

If you want, you can put the dataset in the data folder, it will be copied to /opt/dataset in the virtual machine when building. **Don't push the data in the Git repo**, use the .gitignore file to ignore the data file and prevent it from being versioned.