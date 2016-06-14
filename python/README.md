# Instructions on How to Use Zeus for Python

## Zeus Command Line Interface

### Create New Project :open_file_folder:

```zeus create -python yourprojectdir```

Create a new project in Python with Django stack inside a new directory that is generated during this process called ```yourprojectdir```. You want this because it automates the following steps:

1. Create a new directory called yourprojectdir
2. Copy files that are necessary for Python-Django stack to work inside this directory and make it self-enclosing and self-sufficient
3. ```vagrant up```
4. Vagrant provisioning
5. Copy automation files and a copy of Zeus source code into the Vagrant VM at appropriate places so it is properly configured before you use it. You can also use Zeus inside the VM as though it is still on your local machine.
6. ```vagrant ssh``` for you and you are directly inside the VM and start coding now. Ahh, so many steps cut into one single click.

### Setup Git and GitHub Credentials :octocat:

```zeus gitconfig```

- Inside the Vagrant VM, use this command to overwrite existing or generate new git configuration files so you do not waste time to type in your git and GitHub credentials again and again. If you want to change your git configurations, no need to run the normal git commands which are lenghty and not memorable.

### Create GitHub Repos Directly from Command Line :boom:

```zeus gitcreate public```
```zeus gitcreate private```

- Inside the Vagrant VM, use this command to create a new remote repository on GitHub via the GitHub API without using the GitHub website. You can choose between public and private repositories. You are prompted to enter a custom name of the remote repo. Make sure it is different from existing repos on your GitHub account. It automatically tracks the new repo so there is no need to use ```git remote add origin <newrepo>```. Just ```git add .```, ```git commit```, and ```git push``` and your changes are updated on the newly created repository on GitHub. Magic, isn't it?

## Features

There are three levels where Zeus does its magic. Various features are installed on different levels.

- Your local machine
- Vagrant VM
- Virtualenv within the Vagrant VM (much like onions)

### 1. User's Local Machine Level (aka Your Laptop)

#### Files

- .gitignore, Vagrantfile, provisioning.sh, README.md, Procfile, requirements.txt, runtime.txt

#### Programmes

[WIP] for the release of Version 1.1.0 (on the 30th of June) and not within Version 1.0.0:

- Vagrant, Git, VirtualBox, VirtualBox Extension Pack

### 2. Vagrant VM Level

These are system-wide installations within the Vagrant VM:

#### Programmes

- python2.7, python3.4, python-dev, python3-dev, libpq-dev, pip, build-essential, dos2unix, python-pip, man, Git, Heroku toolbelt, Heroku CLI, ruby, virtualenvwrapper, postgresql, Postgresql-contrib
- Custom commands in the command line via Zeus. Refer to section "How to Use Zeus" to know what commands are available.

#### Configurations

- Initiate a local git repository inside the synced folder `/vagrant`.
- Initiate a virtualenv every time you perform `vagrant ssh`.
- Create Postgres database and its user.
- Store user configurations and credentials for git, Github, and Heroku.
- Zeus CLI available in each vagrant VM initiated by ```zeus create -python yourprojectdir```

### 3. Virtualenv Level Inside the Vagrant VM

#### Programmes

- dj-database-url==0.4.1, Django==1.9.6, django-rest==3.3.3, django-widget-tweaks==1.4.1, gunicorn==19.5.0, psycopg2==2.6.1, whitenoise==3.0

### Vagrant Base-box

Ubuntu 14.04 LTS based box minimal/trusty64, hosted at https://atlas.hashicorp.com/minimal/boxes/trusty64

## Usage

Follow these tutorials to see how you can use Zeus for Python and Django stack:

[asciinema Tutorial by byteknacker](https://asciinema.org/a/1u9zm99yzpz6v1b95wv6mrppn)

or

[Video Tutorial by byteknacker](https://youtu.be/RbQ1qtOVSJc)

Follow these instructions precisely to get started with Zeus:

1. Navigate to the directory inside which you wish to create the new directory for your project.
2. ```git clone https://github.com/alayek/zeus```
3. ```chmod 755 zeus/zeus```
4. ```zeus/zeus yournewprojectdir```
5. Wait until the provision is done for your new Vagrant environment. Take a nap or get a cup of coffee.
6. Follow the input prompt to setup your GitHub and git credentials.
7. Start coding right away inside the synced folder of the Vagrant VM that is synced with your local directory of yourprojectdir.
8. When you finished coding, and you wish to push to Heroku, simply follow the instruction on (Heroku Documentation)[https://devcenter.heroku.com/categories/python]
9. ```git push heroku master```
10. Hurray! You got your first Django app done with Zeus! Please give us some feedback by visiting our (Gitter Chat)[https://gitter.im/FreeCodeCamp/vagrant].

If you get stuck, just visit our Gitter Chat, and you get help asap from collaborators!

### Test Your Setup

Optionally, you might wish to test the development environment setup by following these steps:

- Test manually by checking whether all the features we promised are installed inside your Vagrant VM.
- Use `date && vagrant up > logfile.log && date` instead of just `vagrant up` to log all printouts of `vagrant up` into the `logfile.log` with start time and end time of the execution. (The terminal prints nothing during the entire setup, please don't panic, everything is written into the `logfile.log`). Finally, inspect `logfile.log` to ensure no installation error occurred.
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

1. Fork the main GitHub repo of Zeus
2. Read our [Contributing Docs](https://github.com/alayek/zeus/blob/master/.github/CONTRIBUTING.md) and Wiki pages to get yourself up to speed
3. Join our (Gitter Chat)[https://gitter.im/FreeCodeCamp/vagrant] to ask questions if you are unclear about anything
4. Submit Pull Request from your fork's master branch

## For people who wish to review existing code

1. Pull in the changes from main `master` branch or any pull requests and test them locally on your machine.
2. Follow the steps under the section "Test Your Setup". Use multiple testing methods.

Do not be alarmed by any red-colored text during provisioning. Unless it clearly says _error_ no need to panic!

# Acknowledgements

Many thanks to all those who have helped to develop this Open Source project. We hope that it is useful for you and welcome your feedback. Please feel free to contact anyone of the contributors.

A special acknowledgement to FreeCodeCamp for inviting coders to participate in this project.

# Security and Disclaimer

The Vagrant VM initiated by Zeus stores your GitHub credentials on file. Please do not package this VM and share it. Attempts are made in the future to use HashiCorp Vault to store safely your credentials while not compromising on convenience. Nobody from those who are collaborators, contributors, is liable for any losses or damages arising from security breaches experienced by users.
