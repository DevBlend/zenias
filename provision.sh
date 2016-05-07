#!/usr/bin/env bash

echo "---------------------------------------------"
echo "Running vagrant provisioning"
echo "---------------------------------------------"

sudo apt-get update
sudo apt-get install -y python-pip
sudo wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
sudo apt-get install -y python-dev libpq-dev postgresql postgresql-contrib
sudo pip install virtualenvwrapper
cd /vagrant && virtualenv --python=python3.4 myvenv && source myvenv/bin/activate && pip install -r /vagrant/requirements.txt && django-admin startproject myproject

echo "---------------------------------------------"
echo " Finished."
echo "---------------------------------------------"
