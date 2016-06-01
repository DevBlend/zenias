#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Vagrant configuration file, highly based on
#   https://github.com/tektoh/heroku-cakephp3-app
#   https://github.com/alayek/zeus
#   and some strings found on puphpet boxes (http://puphpet.com)
#
# Author: Manuel Tancoigne
# Original authors:
#   - Shinichi Segawa (https://github.com/tektoh/),
#   - Arijit Layek (https://github.com/alayek/)
#
# This box will create a minimal virtual box (ubuntu trusty-x64) with minimal
# packages required to run an apache2 webserver with php5 and postgreSQL.
#
# CakePHP is a slightly modified version of the official cakePHP 3.2, with minor
# changes to make Heroku deployment a piece of cake.
#
# All credit goes to Shinichi Segawa (tektoh) for his implementation, I only
# updated his work to CakePHP 3.2.
#-------------------------------------------------------------------------------

# Installation settings for a PHP box with CakePHP installed
PROJECT="my_project" # we would want a name passed to it via te first argument, $1
DB="my_app" # the name of postgreSQL DB we need to provision, maybe $2
SERVER="fcc-vagrant-php"

# This file is executed by root user - sudo not needed
# But do not create any directory
# which vagrant user might need access to later in su mode
# use su - vagrant -c "" syntax
export DEBIAN_FRONTEND=noninteractive
echo "---------------------------------------------"
echo "Running vagrant provisioning"
echo "---------------------------------------------"

# Install heroku toolbelt
echo "- Adding heroku toolbelt to packages sources "
# These shell script snippets are directly taken from heroku installation script
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

# Additionnal packages :
#  - man : for documentation
#  - dos2unix : to avoid CR-LF issues on windows (and that would prevent ~/.bashrc to work properly because \r would be unrecognized)
#  - heroku-toolbelt : CLI for Heroku
#  - ruby : needed for heroku toolbelt
#  - curl : needed to download things
#  - Apache2 is installed here so we can update its config before the modules install.
apt-get install -y --no-install-recommends heroku-toolbelt ruby dos2unix man curl apache2
# Set Apache ServerName.
echo "ServerName ${SERVER}" >> /etc/apache2/apache2.conf;

# Installing the PHP dev stack
apt-get install -y --no-install-recommends git postgresql postgresql-contrib phpunit php5 php5-intl php5-pgsql php5-mcrypt php5-sqlite php5-apcu php5-cli

# Install Heroku CLI
su - vagrant -c "heroku --version > /dev/null 2>&1"

# Install postgresql and setup user and DB
echo "---------------------------------------------"
echo "---- Setting up postgresql with ${DB} DB ----"
echo "---------------------------------------------"
# Creating superuser (-s) vagrant
su - postgres -c "createuser -s vagrant"
su - vagrant -c "createdb ${DB}"
# Setting default password for vagrant so Cake can connect
su - vagrant -c "psql -U vagrant -d ${DB} -c \"ALTER USER \\\"vagrant\\\" WITH PASSWORD 'vagrant';\""

# Copying apache config
echo "---------------------------------------------"
echo "------- Configuring Apache2 -----------------"
echo "---------------------------------------------"
cd /vagrant
cp vagrant/000-default.conf /etc/apache2/sites-available/000-default.conf
# Enabling PHP extensions
php5enmod mcrypt
# Enabling mod_rewrite
a2enmod rewrite
# Restarting apache for changes to take effects
service apache2 restart
# Adding user vagrant to www-data group for file permissions
usermod -a -G www-data vagrant

# Downloading composer in site dir.
echo "---------------------------------------------"
echo "- Setting up Composer and Cake dependencies -"
echo "---------------------------------------------"
# Installing composer
if [ ! -e composer.phar ]; then
  curl -sS https://getcomposer.org/installer | sudo php
  export COMPOSER_PROCESS_TIMEOUT=600
  yes | sudo -u vagrant php composer.phar install --prefer-dist
else
  php composer.phar self-update
  yes | sudo -u vagrant php composer.phar update
fi
echo "---------------------------------------------"
echo "-------- Migrating Beer Plugin DB -----------"
echo "---------------------------------------------"
# Migrating sample DB
sudo -u vagrant ./bin/cake migrations migrate -p Beers

# All done
echo "---------------------------------------------"
echo "Everything is up. Use 'vagrant ssh' to log on"
echo "your new box."
echo "---------------------------------------------"

exit 0
