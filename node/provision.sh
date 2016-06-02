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
echo "Running vagrant provisioning"
echo "---------------------------------------------"

# install heroku toolbelt
echo "-------------- Installing heroku toolbelt -------------------------"
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
# These shell script snippets are directly taken from heroku installation script
# We want to avoid the apt-get update
# add heroku repository to apt
echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
# install heroku's release key for package verification
wget -O- https://toolbelt.heroku.com/apt/release.key 2>&1 | apt-key add -

## Add Keys for MongoDB
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

echo "---------------------------------------------"
echo "------- Updating package dependencies -------"
echo "---------------------------------------------"
apt-get update -y # no need for sudo, and -y is needed to bypass the yes-no

echo "---------------------------------------------"
echo "-------- Installing packages ----------------"
echo "---------------------------------------------"
# install gcc and g++ and other build basics to ensure most software works
apt-get install -y --no-install-recommends heroku-toolbelt build-essential
# install the cli
su - vagrant -c "heroku --version > /dev/null 2>&1"

echo "---------------------------------------------"
echo "-------- Installing NVM & Node --------------"
echo "---------------------------------------------"

# install nvm
su - vagrant -c "wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash"

# source bash and install node
su - vagrant <<NVM

source ~/.nvm/nvm.sh
echo 'sourcing done'
nvm install 4.4.3

NVM

echo "---------------------------------------------"
echo "------ Installing MongoDB database ----------"
echo "---------------------------------------------"

apt-get install -y mongodb-org

echo "---------------------------------------------"
echo "------ Installing Essential Packages --------"
echo "---------------------------------------------"

su - vagrant <<ESSENTIALS

source ~/.nvm/nvm.sh
echo "Installing bower"
npm i -g bower
echo "Installing gulp"
npm i -g gulp
echo "Installing Yeoman"
npm i -g yo

ESSENTIALS

echo "---------------------------------------------"
echo "--- Installing Workshopper modules ----------"
echo "---------------------------------------------"

su - vagrant <<WORKSHOPPERS

source ~/.nvm/nvm.sh
echo "Installing javascripting ..."
npm i -g javascripting
echo "Installing learnyounode ..."
npm i -g learnyounode
echo "Installing git-it ..."
npm i -g git-it
echo "Installing how-to-npm ..."
npm i -g how-to-npm
echo "Installing scope-chains-closures ..."
npm i -g scope-chains-closures
echo "Installing stream-adventure ..."
npm i -g stream-adventure
echo "Installing elementary-electron ..."
npm i -g elementary-electron
echo "Installing how-to-markdown ..."
npm i -g how-to-markdown
echo "Installing functional-javascript-workshop ..."
npm i -g functional-javascript-workshop
echo "Installing expressworks ..."
npm i -g expressworks
echo "Installing promise-it-wont-hurt ..."
npm i -g promise-it-wont-hurt
echo "Installing count-to-6 ..."
npm i -g count-to-6

echo "All workshoppers installed."

WORKSHOPPERS

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"
