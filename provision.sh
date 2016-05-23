#!/usr/bin/env bash

# installation settings
PROJECT="my_project" # we would want a name passed to it via te first argument, $1
DB="fcc_provision" # the name of postgreSQL DB we need to provision, maybe $2
ENV_NAME="fcc-py3" # the vitualenv we would like to create, with Python 3.4

# This file is executed by root user - sudo not needed
# But do not create any directory
# which vagrant user might need access to later in su mode
# use su - vagrant -c "" syntax
export DEBIAN_FRONTEND=noninteractive
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
wget -O- https://toolbelt.heroku.com/apt/release.key 2>&1 | apt-key add -

echo "---------------------------------------------"
echo "------- Updating package dependencies -------"
echo "---------------------------------------------"
apt-get update -y # no need for sudo, and -y is needed to bypass the yes-no

echo "---------------------------------------------"
echo "-------- Installing packages ----------------"
echo "---------------------------------------------"
# install gcc and g++ and other build basics to ensure most software works
# install man too
# dos2unix is needed because we could have CR-LF line terminator on Windows
# And that would prevent ~/.bashrc to work properly because \r would be unrecognized
# Ruby needed for heroku toolbelt
# notice that this is not a rigorous Ruby install, where we typically use rvm

apt-get install -y --no-install-recommends heroku-toolbelt build-essential dos2unix python-pip man ruby python-dev python3-dev libpq-dev postgresql postgresql-contrib curl

# install the cli
su - vagrant -c "heroku --version > /dev/null 2>&1"

# install virtualenv and virtualenvwrapper
echo "---------------------------------------------"
echo "------- Installing virtualenvwrapper --------"
echo "---------------------------------------------"
pip install virtualenvwrapper

# install postgresql and setup user
echo "---------------------------------------------"
echo "------- Setting up postgresql ---------------"
echo "---------------------------------------------"
su - postgres -c "createuser -s vagrant"
su - vagrant -c "createdb ${DB}"

echo "---------------------------------------------"
echo "------ Preparing .bashrc for first usage ----"
echo "---------------------------------------------"
# set up virtualenvwrapper and add code to properly
# activate virtualenvwrapper
echo "WORKON_HOME=\"/home/vagrant/.virtualenvs\"" >> /home/vagrant/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh > /dev/null 2>&1" >> /home/vagrant/.bashrc

echo "---------------------------------------------"
echo "------ Creating Python 3 environment --------"
echo "---------------------------------------------"
# Remember to run in vagrantt user mode
# Otherwise, the user would not be able to run pip install without sudo
su - vagrant -c "/usr/local/bin/virtualenv /home/vagrant/.virtualenvs/${ENV_NAME} --python=/usr/bin/python3 && \
    /home/vagrant/.virtualenvs/${ENV_NAME}/bin/pip install -r /vagrant/requirements.txt"

su - vagrant -c "cp /vagrant/.bashrc /home/vagrant/"
su - vagrant -c "mkdir /home/vagrant/.configs"
su - vagrant -c "cp /vagrant/zeus.sh /home/vagrant/.configs/zeus"

# If you are on Windows host, with Git checkout windows line terminator style CRLF
# this comes in handy
su - vagrant -c "dos2unix  /home/vagrant/.bashrc > /dev/null 2>&1"

# Activate the virtualenv on first login
echo "workon ${ENV_NAME}" >> /home/vagrant/.bashrc

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"
