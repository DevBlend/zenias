# FreeCodeCamp Python-Vagrant Autosetup Tool

This repository hosts a tool that creates, with a single command, a platform independent Vagrant development environment with Python-Django stack for [FreeCodeCamp](https://freecodecamp.com) projects.

The motivation for this Open Source project is let users just focus on coding.

## Features

There are three levels: local machine, Vagrant VM, and virtualenv within the Vagrant VM. Various features are installed on different levels.

### User's Local Machine Level

#### Local Files Installed

- .gitignore
- Vagrantfile
- provisioning.sh
- README.md
- Procfile
- requirements.txt
- runtime.txt

#### Local Programmes installed

[WIP] for the next release:

- Vagrant
- Git
- VirtualBox
- VirtualBox Extension Pack

Refer to the section "System Requirements". The next version's system requirements are only Git Bash for Windows and Terminal for Unix-based OS.

### Vagrant VM Level

These are system-wide installations within the Vagrant VM, after running `vagrant ssh`:

#### Programmes

- python2.7
- python3.4
- python-dev
- python3-dev
- libpq-dev
- pip
- build-essential
- dos2unix
- python-pip
- man
- Git
- Heroku toolbelt
- Heroku CLI
- ruby
- virtualenvwrapper
- postgresql
- Postgresql-contrib

#### Configurations

- Initiate a local git repository inside the synced folder `/vagrant`, ready to be pushed to Github
- Initiate a virtualenv every time you perform `vagrant ssh`.
- Create Postgres database and its user.
- [WIP] Secure storage of user configurations and credentials for Github and Heroku.
- [WIP] Initiate `heroku login`, you should be already logged into heroku after `vagrant ssh`.

### Virtualenv Inside Vagrant VM

- dj-database-url==0.4.1
- Django==1.9.6
- django-rest==3.3.3
- django-widget-tweaks==1.4.1
- gunicorn==19.5.0
- psycopg2==2.6.1
- whitenoise==3.0

### Vagrant Base-box

Ubuntu 14.04 LTS based box minimal/trusty64, hosted at https://atlas.hashicorp.com/minimal/boxes/trusty64

## How to Use This Tool

### System Requirements

You need to have the following programmes installed on your local machine before you start to use this tool.

- [Virtualbox](https://www.virtualbox.org/wiki/Downloads) latest (currently version 5.0.20)
- [VirtualBox 5.0.20 Oracle VM VirtualBox Extension Pack](http://download.virtualbox.org/virtualbox/5.0.20/Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931.vbox-extpack), compatible with latest Virtualbox
- [Vagrant](https://www.vagrantup.com/downloads.html), (currently version 1.8.1)
- [Git Bash](https://git-scm.com/downloads) (only if you are on Windows)

If you are on Windows, restart your local machine after the installation of these programmes.

### First Time Usage

1. Run `git clone https://github.com/byteknacker/fcc-python-vagrant.git`
2. Inside the directory path/to/fcc-python-vagrant/ run `vagrant up` in your bash-compliant terminal (Git Bash on Windows, regular terminal on Linux or Mac).
3. Inside the directory path/to/fcc-python-vagrant/ run `vagrant ssh` to start the session inside the development VM.
4. Start coding and forget about development environment setups.

Note that you end up inside the Vagrant VM after these four steps. The VM is isolated from your local machine. Your current working directory has the absolute path of `/vagrant`, which is termed synced folder. It is in real-time sync with your `path/to/fcc-python-vagrant/` local git repo. That is how your local machine communicates with the Vagrant VM.

### Alternative Usage: zeus.py

The reason why you might wish to use `zeus.py` is that it copies pre-set files and directories, configures the directory in which the Vagrant VM is located. In the next version it will also install host-dependent software on the local machine outside of the Vagrant VM, which cannot be done by Vagrant alone.

Furthermore, it leaves your local git repo `fcc-python-vagrant/` untouched and uses it as a static source to initiate the same kind of behaviour as the "First Time Usage" described before. You can now spawn simultaneously multiple "dev containers" on your local machine without any interference from each other. You just have to change directory to switch your development environment.

These are the steps of how to use `zeus.py`:

1. cd ~/Desktop
2. python {absolute path to}/fcc-python-vagrant/zeus.py {newproject}
3. That is it. You are directly in a Vagrant ssh session. Start coding now. You can use this command repetitively for many new directories in which you wish to code.

Legends: {absolute path to} is the absolute directory path of your computer where zeus.py is located, this is presumably in your local git clone of https://github.com/byteknacker/fcc-python-vagrant/

{newproject} is the directory you can name arbitrarily into which everything within `fcc-python-vagrant/` necessary for your new local development environment will be pasted. This is your synced folder in the Vagrant ssh session. All your coding should happen here. Inside your Vagrant ssh session, the absolute path of this synced folder is `/vagrant`.

### Test Your Setup

If you wish you can test the development environment setup by following these steps:

- Test manually by checking whether all the features we promised are installed inside your Vagrant VM.
- Use `date && vagrant up > logfile.log && date` instead of just `vagrant up` to log all printouts of `vagrant up` into the `logfile.log` with start time and end time of the execution. (The terminal will print nothing during the entire setup, please don't panic, everything is written into the `logfile.log`). Finally, inspect `logfile.log` to ensure no installation error occurred.
- Run vagrant halt and restart with `vagrant up` and `vagrant ssh`. Ensure the state of the VM is the same as before, run another test if necessary.
- Automated testing:

It is assumed that these tests would be run inside the standard virtualenv of the `vagrant ssh` session.

It would require the `py.test` module to run it, which can be installed as:

```bash
$ pip install pytest
```

Then navigate to the top-level directory of the Vagrant synced folder:

```bash
$ cd /vagrant
```

Invoke the automated tests:

```bash
$ py.test -v
```

You should see all tests PASSED and no errors printed.

# Contributing Guidelines

## For people who wish to write new code

1. Fork this GitHub repo
2. Read the latest software specification [here](https://docs.google.com/document/d/1VkHJRZs0XdL2ne1Z55eAWL8pLrhdhpb7i60dpph0jmY/)
3. Join our Slack Team. Sign up via this [form](https://johnwu.typeform.com/to/ifhehu)
4. Observe the SCRUM board on [Trello](https://trello.com/b/wdC4OXE4/fcc-python-vagrant) and take up one of the pending tasks or create a new task. Please contact a contributor and ask for permission to join the Trello Board.
4. Start coding
5. Submit Pull Request

## For people who wish to review existing code

1. Pull in the changes from main `master` branch or any pull requests and test them locally on your machine.
2. Follow the steps under the section "Test Your Setup". Use multiple testing methods.

Do not be alarmed by any red-colored text during provisioning. Unless it clearly says _error_ no need to panic!

# Acknowledgement

Many thanks to all those who have helped to develop this Open Source project. We hope that it is useful for you and welcome your feedback. Please feel free to contact anyone of the contributors.

A special acknowledgement to FreeCodeCamp for inviting coders to participate in this project.
