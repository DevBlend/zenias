# FreeCodeCamp Ruby-Vagrant Autosetup Tool

This repository hosts a tool that creates, with a single command, a Vagrant development environment with Ruby-Rails stack for [FreeCodeCamp](https://freecodecamp.com) back-end and API projects.

The motivation for this BSD-3 licensed open source project is to let users just focus on coding and building, instead of getting stuck with installation issues.

## Features

There are three levels: local machine, Vagrant VM, and virtualenv within the Vagrant VM. Various features are installed on different levels.

### User's Local Machine Level

#### Local Files Installed

- .gitignore
- Vagrantfile
- Berksfile
- Berksfile.lock
- README.md
- LICENSE


#### Local Programs installed

[WIP] for the next release:

- Vagrant
- Git
- VirtualBox
- VirtualBox Extension Pack

Refer to [System Requirements](#system-requirements). The next version's system requirements are only Git Bash for Windows and Terminal for Unix-based OS or Mac OSX.

### Vagrant VM Level

These are system-wide installations within the Vagrant VM, after running `vagrant ssh`:

#### Programmes

- ruby 2.3.1
- rbenv
- build-essential
- rails 4.2.x
- dos2unix -nope
- gem
- bundle
- rake
- RSpec
- man
- Git
- Heroku toolbelt
- Heroku CLI
- PostgreSQL
- Postgresql-contrib

#### Configurations

- Initiates a local git repository inside the synced folder `/vagrant`, ready to be pushed to Github
- Initiates a virtualenv every time you perform `vagrant ssh`.
- Create Postgres database and its user.
- [WIP] Secure storage of user configurations and credentials for Github and Heroku.
- [WIP] Initiate `heroku login`, you should be already logged into heroku after `vagrant ssh`.

### Vagrant Base-box

Ubuntu 14.04 LTS based box minimal/trusty64, hosted [here](https://atlas.hashicorp.com/minimal/boxes/trusty64)

## How to Use This Tool

### System Requirements

You need to have the following programmes installed on your local machine before you start to use this tool.

- [Virtualbox](https://www.virtualbox.org/wiki/Downloads) latest (currently version 5.0.20)
- [VirtualBox 5.0.20 Oracle VM VirtualBox Extension Pack](http://download.virtualbox.org/virtualbox/5.0.20/Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931.vbox-extpack), compatible with latest Virtualbox
- [Vagrant](https://www.vagrantup.com/downloads.html), (currently version 1.8.1)
- [Git Bash](https://git-scm.com/downloads) (only if you are on Windows)

If you are on Windows, restart your local machine after the installation of these programmes.

### First Time Usage
1. `vagrant plugin install vagrant-berksfile`
2. `git clone https://github.com/alayek/zeus.git`
3. Navigate to the directory of this cloned repo. `cd your/path/to/zeus/ruby`
4. `vagrant up` in your bash-compliant terminal (Git Bash on Windows, regular terminal on Linux or Mac).
5. Inside the directory `your/path/to/zeus/ruby` run `vagrant ssh` to start the session inside the development VM.
6. Complete Github and git config setup. You only need to login to Github once during your first push and never again. You don't need to authenticate yourself when you perform git commit.
7. Start coding.

# Contributing Guidelines

We are not accepting pull requests at the moment. However, if you wish to contribute, do get in touch with us [here](https://gitter.im/FreeCodeCamp/ruby)

# Acknowledgement

Many thanks to all those who have helped to develop this Open Source project. We hope that it is useful for you and welcome your feedback. Please feel free to contact anyone of the contributors.

A special acknowledgement to FreeCodeCamp for inviting coders to participate in this project.
