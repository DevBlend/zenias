# NodeSchool-Vagrant

Vagrant Box to have all [Nodeschool](http://nodeschool.io) workshoppers as a dependency. Primarily made for [Nodeschool IEM-Kolkata International Day Workshop](http://nodeschool.io/iem-kolkata/).

Motivated by [ByteKnacker](https://github.com/byteknacker)'s awesome [fcc-python-vagrant](https://github.com/byteknacker/fcc-python-vagrant) Project and now merged with [Zeus](https://github.com/DevBlend/DevBlend) Project.

## Features

All dependencies are listed in `provision.sh` to be installed.

* Node version : 4.4.3 (Installed via nvm)
* Npm version : 2.15.1

Workshopper modules installed :

* javascripting
* learnyounode
* git-it
* how-to-npm
* scope-chains-closures
* stream-adventure
* elementary-electron
* how-to-markdown
* functional-javascript-workshop
* expressworks
* promise-it-wont-hurt
* count-to-6

Other programs installed :

* Heroku toolbelt
* Heroku CLI

## Installation

To run this vagrant box, you must have the following dependencies installed :

- [Virtualbox](https://www.virtualbox.org/wiki/Downloads) latest (currently version 5.0.20)
- [VirtualBox 5.0.20 Oracle VM VirtualBox Extension Pack](http://download.virtualbox.org/virtualbox/5.0.20/Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931.vbox-extpack), compatible with latest Virtualbox
- [Vagrant](https://www.vagrantup.com/downloads.html), (currently version 1.8.1)
- [Git Bash](https://git-scm.com/downloads) (only if you are on Windows)

If you are on Windows, restart your local machine after the installation of these programmes.

### First Time Usage

1. Run `git clone https://github.com/DevBlend/DevBlend.git`
2. Inside the directory path/to/node/ run `vagrant up` in your bash-compliant terminal (Git Bash on Windows, regular terminal on Linux or Mac).
3. Inside the directory path/to/node/ run `vagrant ssh` to start the session inside the development VM.
4. Start coding and forget about development environment setups.

Note that you end up inside the Vagrant VM after these four steps. The VM is isolated from your local machine. Your current working directory has the absolute path of `/vagrant`, which is termed synced folder. It is in real-time sync with your `path/to/nodeschool-vagrant/` local git repo. That is how your local machine communicates with the Vagrant VM.

## LICENSE

[MIT](https://koustuvs.mit-license.org/)
