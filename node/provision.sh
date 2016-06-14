#!/usr/bin/env bash

# installation settings
PROJECT="nodeschool" # we would want a name passed to it via te first argument, $1
DB="nodeschool" # the name of postgreSQL DB we need to provision, maybe $2

# This file is executed by root user - sudo not needed
# But do not create any directory
# which vagrant user might need access to later in su mode
# use su - vagrant -c "" syntax
export DEBIAN_FRONTEND=noninteractive
echo "---------------------------------------------"
echo "------- Running vagrant provisioning --------"
echo "---------------------------------------------"

# install heroku toolbelt
echo "-------------- Installing heroku toolbelt -------------------------"
# These shell script snippets are directly taken from heroku installation script
# We want to avoid the apt-get update
# add heroku repository to apt
echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
# install heroku's release key for package verification
wget -O- https://toolbelt.heroku.com/apt/release.key 2>&1 | apt-key add - > /dev/null
## Add Keys for MongoDB
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 >/dev/null 2>&1
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

echo "---------------------------------------------"
echo "------- Updating package dependencies -------"
echo "---------------------------------------------"
apt-get update -y # no need for sudo, and -y is needed to bypass the yes-no

echo "---------------------------------------------"
echo "----- Installing packages and Mongo DB ------"
echo "---------------------------------------------"
# install gcc and g++ and other build basics to ensure most software works
apt-get install -y --no-install-recommends heroku-toolbelt build-essential mongodb-org
# install the cli
su - vagrant -c "heroku --version > /dev/null 2>&1"

echo "---------------------------------------------"
echo "-------- Installing NVM & Node --------------"
echo "---------------------------------------------"

# source bash and install node
su - vagrant <<NVM
# install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | sh 
source ~/.nvm/nvm.sh > /dev/null 2>&1
echo 'sourcing done'
nvm install 4.4.3 > /dev/null 2>&1
echo "---------------------------------------------"
echo "-------- Installing NPM Packages ------------"
echo "---------------------------------------------"
echo "Installing bower"
npm i -g bower > /dev/null 2>&1
echo "Installing gulp"
npm i -g gulp > /dev/null 2>&1
echo "Installing Yeoman"
npm i -g yo > /dev/null 2>&1
echo "Installing Express"
npm i -g express > /dev/null 2>&1
echo "Installing workshopper modules"
npm i -g git-it learnyounode how-to-npm learnyoumongo expressworks > /dev/null 2>&1
NVM

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"