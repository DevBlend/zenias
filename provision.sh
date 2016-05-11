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

# install heroku toolbelt
echo "-------------- Installing heroku toolbelt -------------------------"
#wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
# These shell script snippets are directly taken from heroku installation script
# We want to avoid the apt-get update
# add heroku repository to apt
echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
# install heroku's release key for package verification
wget -O- https://toolbelt.heroku.com/apt/release.key | apt-key add -

echo "------------- Updating packages and their dependencies -----------"
apt-get update -y # no need for sudo, and -y is needed to bypass the yes-no

# install the toolbelt
apt-get install heroku-toolbelt --no-install-recommends -y

echo "-------------- Installing build-essential and pip ----------------"
# install gcc and g++ and other build basics to ensure most software works
# install man too
apt-get install build-essential python-pip man -y --no-install-recommends

# needed for heroku toolbelt
# notice that this is not a rigorous Ruby install, where we typically use rvm
apt-get install ruby --no-install-recommends -y

# install virtualenv and virtualenvwrapper
echo "--------------- Installing both virtualenv and virtualenvwrapper ---"
pip install virtualenvwrapper virtualenv

# install postgresql and setup user
echo "--------------- Installing postgresql ------------------------------"
apt-get install python-dev python3-dev libpq-dev postgresql postgresql-contrib --no-install-recommends -y
su - postgres -c "createuser -s vagrant"
su - vagrant -c "createdb ${DB}"

echo "--------------- Preparing .bashrc for first usage ------------------"
# set up virtualenvwrapper
echo WORKON_HOME="/home/vagrant/.virtualenvs" >> /home/vagrant/.bashrc
# activate virtualenvwrapper
echo "WORKON_HOME=\"/home/vagrant/.virtualenvs\"" >> /home/vagrant/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh > /dev/null 2>&1" >> /home/vagrant/.bashrc

echo "---------------- Creating virtual environment with Python 3 ---------"
# Remember to run in vagrantt user mode
# Otherwise, the user would not be able to run pip install without sudo
su - vagrant -c "/usr/local/bin/virtualenv /home/vagrant/.virtualenvs/${ENV_NAME} --python=/usr/bin/python3 && \
    /home/vagrant/.virtualenvs/${ENV_NAME}/bin/pip install -r /vagrant/requirements.txt"

# take the user to shared directory
echo "cd /vagrant" >> /home/vagrant/.bashrc

# Activate the virtualenv on first login
echo "workon ${ENV_NAME}" >> /home/vagrant/.bashrc

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"
