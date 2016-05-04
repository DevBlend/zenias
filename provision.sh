#!/usr/bin/env bash

echo "---------------------------------------------"
echo "Running vagrant provisioning"
echo "---------------------------------------------"

sudo apt-get update
sudo apt-get install -y python-pip
sudo apt-get install -y git
sudo apt-get install -y nano
sudo pip install virtualenvwrapper

echo "---------------------------------------------"
echo "Environment setup complete!"
echo "---------------------------------------------"

echo "---------------------------------------------"
echo "Installing django"
echo "---------------------------------------------"
sudo mkdir /vagrant
sudo wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
cd /vagrant && virtualenv --python=python3.5 myvenv && source myvenv/bin/activate && pip install django==1.9.5 && django-admin startproject myproject && pip install django-widget-tweaks
