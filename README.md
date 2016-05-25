# FreeCodeCamp - Zeus

Zeus is a tool that creates quickly a platform-independent Vagrant development environment. Currently, Python-Django stack is supported but many more plugins, such as Ruby stack, are under development.

Zeus was initially made for students of [FreeCodeCamp](https://freecodecamp.com).

The motivation for this Open Source project is let users focus only on coding web apps.

Zeus relies on [Vagrant](https://www.vagrantup.com/). It is a tool that automates the setup of development environments and provisioning of that environment.

## Features

There are three levels that zeus will change: your local machine, Vagrant VM, and virtualenv within the Vagrant VM. Various features are installed on different levels.

### 1. User's Local Machine Level

#### Files

- .gitignore, Vagrantfile, provisioning.sh, README.md, Procfile, requirements.txt, runtime.txt

#### Programmes

[WIP] for the release of Version 0.2.0 (in June) and not within Version 0.1.0:

- Vagrant, Git, VirtualBox, VirtualBox Extension Pack

### 2. Vagrant VM Level

These are system-wide installations within the Vagrant VM:

#### Programmes

- python2.7, python3.4, python-dev, python3-dev, libpq-dev, pip, build-essential, dos2unix, python-pip, man, Git, Heroku toolbelt, Heroku CLI, ruby, virtualenvwrapper, postgresql, Postgresql-contrib
- Custom commands in the command line via zeus. Refer to section "How to Use Zeus" to know what commands are available.

#### Configurations

- Initiate a local git repository inside the synced folder `/vagrant`.
- Initiate a virtualenv every time you perform `vagrant ssh`.
- Create Postgres database and its user.
- Store user configurations and credentials for git, Github, and Heroku.

### 3. Virtualenv Level

#### Programmes

- dj-database-url==0.4.1, Django==1.9.6, django-rest==3.3.3, django-widget-tweaks==1.4.1, gunicorn==19.5.0, psycopg2==2.6.1, whitenoise==3.0

### Vagrant Base-box

Ubuntu 14.04 LTS based box minimal/trusty64, hosted at https://atlas.hashicorp.com/minimal/boxes/trusty64

## How to Use Zeus

### System Requirements

You need to have the following programmes installed on your local machine before you start to use this tool.

- [Virtualbox](https://www.virtualbox.org/wiki/Downloads) latest (currently version 5.0.20)
- [VirtualBox 5.0.20 Oracle VM VirtualBox Extension Pack](http://download.virtualbox.org/virtualbox/5.0.20/Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931.vbox-extpack), compatible with latest Virtualbox
- [Vagrant](https://www.vagrantup.com/downloads.html), (currently version 1.8.1)
- [Python 2.7](https://www.python.org/downloads/)
- [Git Bash](https://git-scm.com/downloads) (only if you are on Windows)

If you are on Windows, restart your local machine after the installation of these programmes.

### Standard Usage

1. `git clone https://github.com/byteknacker/fcc-python-vagrant.git`
2. Navigate to the directory of this cloned repo.
`cd your/path/to/fcc-python-vagrant`
3. `vagrant up` in your bash-compliant terminal (Git Bash on Windows, regular terminal on Linux or Mac).
3. Inside the directory `your/path/to/fcc-python-vagrant` run `vagrant ssh` to start the session inside the development VM.
4. Complete Github and git config setup. You only need to login to Github once during your first push and never again. You don't need to authenticate yourself when you perform git commit.
5. Start coding.

Note that you end up inside the Vagrant VM after these four steps. The VM is isolated from your local machine. Your current working directory has the absolute path of `/vagrant`, which is termed the "synced directory". It is in real-time sync with the `your/path/to/fcc-python-vagrant` local git repo. That is how your local machine communicates with the Vagrant VM.

### Zeus CLI

Run these commands within your Vagrant ssh session.

- `zeus gitconfig`
Create or overwrite existing git configuration for the user in terms of username and email address. Git push is set to simple as this is best practice.
- `zeus gitcreate private` or `zeus gitcreate public`
Create a private or public repository on Github via the GitHub API. You need to first have setup your git configurations with `zeus gitconfig` to use this properly. You only need to specify the name you wish to give to the remote repository.

### Alternative Usage: zeus.py

The reason why you might wish to use `zeus.py` is that it copies pre-set files and directories, configures the directory in which the Vagrant VM is located. You can also create multiple VMs simultaneously. Furthermore, it leaves your local git repo `your/path/to/fcc-python-vagrant`.

These are the steps to use `zeus.py`:

1. `cd ~/Desktop`
2. `python your/path/to/fcc-python-vagrant/zeus.py <newproject>`
3. That is it. You are directly in a Vagrant ssh session. Start coding now.

Nota Bene:

<newproject> is the directory you with to create in side which you are going to code your web apps. This is your synced folder in the Vagrant ssh session. All your coding should happen here. If you exit the Vagrant ssh session, you might end up in a different directory. Please navigate to wherever <newproject> is located and start your VM session again with `vagrant ssh`

### Test Your Setup

Optionally, you might wish to test the development environment setup by following these steps:

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
4. Submit Pull Request

## For people who wish to review existing code

1. Pull in the changes from main `master` branch or any pull requests and test them locally on your machine.
2. Follow the steps under the section "Test Your Setup". Use multiple testing methods.

Do not be alarmed by any red-colored text during provisioning. Unless it clearly says _error_ no need to panic!

# Acknowledgement

Many thanks to all those who have helped to develop this Open Source project. We hope that it is useful for you and welcome your feedback. Please feel free to contact anyone of the contributors.

A special acknowledgement to FreeCodeCamp for inviting coders to participate in this project.

# Security

The Vagrant VM initiated by zeus stores your GitHub credentials on file. Please do not package this VM and share it. Attempts are made in the future to use HashiCorp Vault to store safely your credentials while not compromising on convenience.
