#!/usr/bin/env bash

echo "---------------------------------------------"
echo "Running vagrant provisioning"
echo "---------------------------------------------"

sudo apt-get update
sudo apt-get install -y python-pip
sudo apt-get install -y git
sudo pip install virtualenvwrapper
sudo wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
cd /vagrant && virtualenv --python=python3.4 myvenv && source myvenv/bin/activate && pip install django==1.9.5 && django-admin startproject myproject && pip install django-widget-tweaks

echo "---------------------------------------------"
echo " Finished."
echo "---------------------------------------------"
