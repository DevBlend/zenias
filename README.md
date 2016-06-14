# DevBlend - Zenias

[![Join the chat at https://gitter.im/FreeCodeCamp/vagrant](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/FreeCodeCamp/vagrant)

## Table of Contents
- [What is Zenias](#what-is-zenias)
- [Current Version](#current-version)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
  - [Zenias _host_](#zenias-host)
  - [Zenias _guest_](#zenias-guest)
- [Configuration](#configuration)
- [Security note](#security-note)
- [License](#license)

## What is Zenias

_Zenias_ is a CLI tool that creates a platform-independent [Vagrant](https://www.vagrantup.com) development environment with integration for github and Heroku.

## Current Version

Present version of this project stands at 1.1.2. We use Semvar based versioning.


## Requirements

You will need a few programs installed for Zenias to work:

  - VirtualBox - the virtualization solution 
    - [Download](https://www.virtualbox.org/wiki/Downloads),
    - [Download Extension pack](https://www.virtualbox.org/wiki/Downloads) for USB 2.0 support;
  - Vagrant - creates lightweight and reproductible development environments
    - [Download](https://www.vagrantup.com/downloads.html).
  - Git
    - If you are on Windows, you need [Git Bash](https://git-scm.com/downloads).
    - For other platforms, use either the version of your package manager or the one from [the official website](https://git-scm.com/downloads).
  - [Python 2.7](https://www.python.org/downloads/) - Zenias is writen in python and python is available for every platform.
  - Pip (python dependencies management) with `pyyaml` and `gitpython`

## Installation

  1. Download Zenias or clone it, as you prefer
  2. Install requirements
  3. Add zenias to your PATH or create aliases, so it's accessible from anywhere:
    - Linux: add an alias like `alias zenias /path/to/zenias` in your `~/.bashrc` file
    - For win/mac, I need more infos :)
  4. Read the usage section of this readme

## How to Use Zenias

There are two zenias scripts to be considered : zenias _host_ and zenias _guest_.

### zenias _host_
It's the script ran on your host machine, which sets the boxes. It have a few commands:

#### zenias create
This will create a box and run vagrant for it:
```sh
zenias create <box> <directory> 
```
To create a box in the current dir, use `.` as the directory argument.

#### zenias list
This command lists the available boxes:
```sh
# full list:
zenias list

# List for a given language
zenias list -l <language>
```

#### zenias template
Creates an empty box, to be customized and used/shared on git systems

```sh
zenias template <boxname> <directory>
```
To create a template in the current dir, use `.` as the directory argument.

### Zenias _guest_

** THIS SECTION HAS NOT BEEN UPDATED AS THE SCRIPT IS NOT FINISHED **

Run these commands within your Vagrant ssh session.

- `zenias gitconfig`
Create or overwrite existing git configuration for the user in terms of username and email address. Git push is set to simple as this is best practice.
- `zenias gitcreate private` or `zenias gitcreate public`
Create a private or public repository on Github via the GitHub API. You need to first have setup your git configurations with `zenias gitconfig` to use this properly. You only need to specify the name you wish to give to the remote repository.


Nota Bene:

<newproject> is the directory you with to create in side which you are going to code your web apps. This is your synced folder in the Vagrant ssh session. All your coding should happen here. If you exit the Vagrant ssh session, you might end up in a different directory. Please navigate to wherever <newproject> is located and start your VM session again with `vagrant ssh`

## Configuration
Zenias comes with a list of _official_ repos in `repos.yml` (tested by the zenias team). When you launch Zenias for the first time, it will create a `.zenias_custom.yml`.

You can add custom non-official repos in it and then use them as you would have done for the official ones.

## Security note
When you run zenias in the guest it stores Github credentials in `/home/vagrant/config/`, and heroku credentials are saved bu the heroku toolbelt. **IF YOU SHARE THE WHOLE VM, YOU SHARE YOUR ACCESSES TO THESE SERVICES**.
