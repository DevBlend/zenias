#!/usr/bin/env bash

echo "---------------------------------------------"
echo "Running vagrant provisioning"
echo "---------------------------------------------"

sudo apt-get update
sudo apt-get install -y python-pip
sudo wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
sudo pip install virtualenvwrapper
sudo apt-get install -y python-dev libpq-dev postgresql postgresql-contrib
sudo su - postgres << EOF
psql postgres -c "CREATE DATABASE fcc_project"
psql postgres -c "CREATE USER fcc WITH PASSWORD 'fcc'"
psql postgres -c "GRANT ALL PRIVILEGES ON DATABASE fcc_project TO fcc"
exit
EOF
cd /vagrant && virtualenv --python=python3.4 myvenv && source myvenv/bin/activate && pip install -r /vagrant/requirements.txt && django-admin startproject myproject

echo "---------------------------------------------"
echo " Finished."
echo "---------------------------------------------"
