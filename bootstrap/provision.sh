#!/usr/bin/env bash

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
apt-get install -y --no-install-recommends heroku-toolbelt build-essential dos2unix man curl
# install the cli
su - vagrant -c "heroku --version > /dev/null 2>&1"

echo "---------------------------------------------"
echo "------ Preparing .bashrc for first usage ----"
echo "---------------------------------------------"

su - vagrant -c "mv /vagrant/.bashrc /home/vagrant/"
su - vagrant -c "mkdir /home/vagrant/.configs"
su - vagrant -c "mv /vagrant/zeus /home/vagrant/.configs/zeus"
# If you are on Windows host, with Git checkout windows line terminator style CRLF
# this comes in handy
su - vagrant -c "dos2unix  /home/vagrant/.bashrc > /dev/null 2>&1"

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"
