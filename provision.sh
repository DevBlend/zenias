#!/usr/bin/env bash

# installation settings
PROJECT="my_project" # we would want a name passed to it via te first argument, $1
DB="fcc_provision" # the name of postgreSQL DB we need to provision, maybe $2
ENV_NAME="fcc-py3" # the vitualenv we would like to create, with Python 3.4

# This file is executed by root user - sudo not needed
# But do not create any directory
# which vagrant user might need access to later in su mode
# use su - vagrant -c "" syntax

echo "---------------------------------------------"
echo "Running vagrant provisioning"
echo "---------------------------------------------"

echo "------------- Updating packages and their dependencies -----------"
apt-get update -y # no need for sudo, and -y is needed to bypass the yes-no
echo "-------------- Installing build-essential and pip ----------------"
apt-get install -y build-essential python-pip

# install heroku toolbelt
echo "-------------- Installing heroku toolbelt -------------------------"
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# install virtualenv and virtualenvwrapper
echo "--------------- Installing both virtualenv and virtualenvwrapper ---"
pip install virtualenvwrapper virtualenv

echo "--------------- Preparing .bashrc for first usage ------------------"
# set up virtualenvwrapper
echo WORKON_HOME="/home/vagrant/.virtualenvs" >> /home/vagrant/.bashrc
# activate it
echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/vagrant/.bashrc
echo "WORKON_HOME=\"/home/vagrant/.virtualenvs\"" >> /home/vagrant/.bashrc

echo "---------------- Creating virtual environment with Python 3 ---------"
# Remember to run in vagrantt user mode
# Otherwise, the user would not be able to run pip install without sudo
su - vagrant -c "/usr/local/bin/virtualenv /home/vagrant/.virtualenvs/${ENV_NAME} --python=/usr/bin/python3 && \
    /home/vagrant/.virtualenvs/${ENV_NAME}/bin/pip install -r /vagrant/requirements.txt"

#cd /vagrant && virtualenv --python=python3.4 myvenv && source myvenv/bin/activate && pip install -r /vagrant/requirements.txt && django-admin startproject myproject

# take the user to shared directory
echo "cd /vagrant" >> /home/vagrant/.bashrc

# Activate the virtualenv on first login
echo "workon ${ENV_NAME}" >> /home/vagrant/.bashrc

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"
