# FreeCodeCamp Python Vagrant Box [WIP]

This repository hosts the Vagrant file (and associated tool) that would create the portable Vagrant environment for Python-based ful-stack development on [FreeCodeCamp](https://freecodecamp.com) projects.

At present, we are focused only on getting a minimalistic version of Python web development environment up and running.

The vagrant file is optimized for _size_ of download to be as less as possible.

## Possible Base

To minimize download size, we could look at one of the following possible bases:
- Debian
- Arch-Linux
- CentOS
- Ubuntu LTS server

## Packages

The following packages should be installed within the Vagrant environment:

### Outside virtual environment
- [Python 3](https://www.python.org/download/releases/3.0/)
- [Virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/) and [Virtualenv](https://virtualenv.pypa.io/en/latest/)
- [PostgreSQL](http://www.postgresql.org/)
- [Heroku toolbelt](https://toolbelt.heroku.com/)
- [Git](https://git-scm.com/)

### Inside virtual environment

Inside a typical Python 3 based virtual environment, these Python packages are to be installed with `pip`:

- [Psycopg](http://initd.org/psycopg/docs/install.html)
- [Django (latest, stable)](https://www.djangoproject.com/)
- [Django-REST](http://www.django-rest-framework.org/)

## Usage
The user should be able to download and run a `vagrant up` in their bash-compliant terminal (Git Bash on Windows, regular terminal on Linux or Mac), and directly get into a Python 3 virtualenv with Django installed and PostgreSQL running.

The idea is to minimize _installation fatigue_ as much as possible for end-user; and have them focus on working on their project.

## Software Specification
Latest software specification can be found in the [Google Doc](https://docs.google.com/document/d/1VkHJRZs0XdL2ne1Z55eAWL8pLrhdhpb7i60dpph0jmY/)


## Trello for SCRUM Board
Our trello scrum board can be found [here](https://trello.com/b/wdC4OXE4/fcc-python-vagrant).

## Contributing Guidelines
We are not accepting pull requests at the moment, until the project is at least in MVP stage. Once that happens, we would link to a gitter chatroom, where you can work with us and submit pull request.
