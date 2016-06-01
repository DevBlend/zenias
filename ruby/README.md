# FreeCodeCamp Ruby-Vagrant Autosetup Tool

This repository hosts a tool that creates, with a single command, a Vagrant development environment with Ruby-Rails stack for [FreeCodeCamp](https://freecodecamp.com) back-end and API projects.

The motivation for this BSD-3 licensed open source project is to let users just focus on coding and building, instead of getting stuck with installation issues.

## Features

There are three levels: local machine, Vagrant VM, and virtualenv within the Vagrant VM. Various features are installed on different levels.

### User's Local Machine Level

#### Local Files Installed

- .gitignore
- Vagrantfile
- Cheffile
- README.md

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

1. Run `git clone https://github.com/alayek/fcc-ruby-vagrant.git`
2. Inside the directory path/to/fcc-python-vagrant/ run `vagrant up` in your bash-compliant terminal (Git Bash on Windows, regular terminal on Linux or Mac).
3. Inside the directory path/to/fcc-python-vagrant/ run `vagrant ssh` to start the session inside the development VM.
4. Start coding and forget about development environment setups.

Note that you end up inside the Vagrant VM after these four steps. The VM is isolated from your local machine. Your current working directory has the absolute path of `/vagrant`, which is termed synced folder. It is in real-time sync with your `path/to/fcc-python-vagrant/` local git repo. That is how your local machine communicates with the Vagrant VM.


### Test Your Setup

If you wish you can test the development environment setup by following these steps:

- Test manually by checking whether all the features we promised are installed inside your Vagrant VM.
- Use `date && vagrant up > logfile.log && date` instead of just `vagrant up` to log all printouts of `vagrant up` into the `logfile.log` with start time and end time of the execution. (The terminal will print nothing during the entire setup, please don't panic, everything is written into the `logfile.log`). Finally, inspect `logfile.log` to ensure no installation error occurred.
- Run vagrant halt and restart with `vagrant up` and `vagrant ssh`. Ensure the state of the VM is the same as before, run another test if necessary.
- Automated testing:

It is assumed that these tests would be run inside the standard virtualenv of the `vagrant ssh` session.


### TODO : Automated Testing

You should see all tests PASSED and no errors printed.

# Contributing Guidelines

We are not accepting pull requests at the moment. However, if you wish to contribute, do get in touch with us [here](https://gitter.im/FreeCodeCamp/ruby)

# Acknowledgement

Many thanks to all those who have helped to develop this Open Source project. We hope that it is useful for you and welcome your feedback. Please feel free to contact anyone of the contributors.

A special acknowledgement to FreeCodeCamp for inviting coders to participate in this project.
