# FreeCodeCamp Python Vagrant Box [WIP]

This repository hosts the Vagrant file and associated automation tools that create a portable Vagrant development environment for Python-Django full-stack development for [FreeCodeCamp](https://freecodecamp.com) projects.

The motivation for this Open Source project is to minimise installation fatigue as much as possible for the end-user who can focus on working on their project. As such, the Vagrantfile is optimised in terms of the size of the box for speedy download and setup.

## Vagrant Base Box

We are currently using Ubuntu 14.04 LTS based server hosted on https://atlas.hashicorp.com under the URL: ubuntu/trusty64. Contact us if you discover similar boxes that are smaller in size. We will exchange the old for the smaller one. We are looking for a box that is less than 300 MB large.

## Installed Packages

The following packages should be installed within the Vagrant environment during provisioning:

### Outside Virtual Environment

- [Python 3.4](https://www.python.org/download/releases/3.0/)
- [pip](https://pip.pypa.io/en/stable/installing/)
- [Virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/) with [Virtualenv](https://virtualenv.pypa.io/en/latest/)
- [PostgreSQL](http://www.postgresql.org/)
- [Heroku Toolbelt](https://toolbelt.heroku.com/)
- [Git](https://git-scm.com/)

### Inside Virtual Environment

Python 3.4 will be invoked as python. Inside a typical Python 3.4 based virtual environment, these Python packages are installed with pip:

- [Django 1.9.5](https://www.djangoproject.com/)
- [Django-widget-tweaks](https://github.com/kmike/django-widget-tweaks)

There are more packages to be introduced later.

## How to Use this App
### First Time Usage

1. git clone https://github.com/byteknacker/fcc-python-vagrant.git
2. Run vagrant up in your bash-compliant terminal (Git Bash on Windows, regular terminal on Linux or Mac).
3. Run vagrant ssh to start the session inside the development VM.
4. Start coding your app.

### Test Your Changes

You need to test the vagrant install properly. Things that could help you:
- Test manually, by installing on your own machine(s).
- Use `date && vagrant up > logfile.log && date` to log start time and end time properly.
- Inspect `logfile.log` to ensure no installation error occurred.
- Shut down the box, then restart with `vagrant up` and `vagrant ssh` into it. Ensure all standard things run properly.

### Future Projects

1. Go to your directory in which you wish to place your new project. Decide
for a project name: <projectname>.
2. Run the following command to setup the entire development environment:
`python /absolute/path/to/zeus.py <projectname>` where zeus.py is invoke from
within the local git repo of this repository. This presumes that you have
python2.7 + installed on your local machine.
3. After running the previous command you will be taken directly into
the vagrant ssh session and you can start coding straight away.

## Tests for this App

Tests are there to ensure the integrity of the vagrant guest OS and packages installed within it.

It would require the `py.test` module to run it, which can be installed as:

```bash
$ pip install pytest
```

Once installed, go to the test directory, and run the tests. Run the tests inside the vagrant ssh session but there is no need to run them inside a virtual environment The test scripts are Python 2.x and Python 3.x compatible.

It is assumed that these tests would be run after the `vagrant up` has finished and the vagrant environment.

Invoke the tests inside the vagrant environment, from within the `tests` directory as:

```bash
$ py.test -v test_runner.py
```

## Software Specification

The latest software specification can be found on [Google Docs](https://docs.google.com/document/d/1VkHJRZs0XdL2ne1Z55eAWL8pLrhdhpb7i60dpph0jmY/)


## Trello for SCRUM Board

Our Trello SCRUM board can be found [here:](https://trello.com/b/wdC4OXE4/fcc-python-vagrant).

## Contributing Guidelines

We are not accepting pull requests at the moment until the project is at least in an MVP stage. Then we would link the project to a gitter chatroom where you can work with us and submit pull request.
