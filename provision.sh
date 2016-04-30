#!/usr/bin/env bash

echo "---------------------------------------------"
echo "Running vagrant provisioning"
echo "---------------------------------------------"

sudo apt-get update
# Not sure yet if pip is pre-installed on minimal/trusty64
# sudo apt-get install -y python-pip
# sudo pip install virtualenvwrapper

echo "---------------------------------------------"
echo " Finished."
echo "---------------------------------------------"
