#!/usr/bin/env bash

#-----------------------------------------------------------------------
# Vagrant configuration file for CakePHP3 setup
#   https://github.com/tektoh/heroku-cakephp3-app
#   and some strings found on puphpet boxes (http://puphpet.com)
#
# Author: Manuel Tancoigne
# Original authors:
#   - Shinichi Segawa (https://github.com/tektoh/),
#
# CakePHP is a slightly modified version of the official cakePHP 3.2, with minor
# changes to make Heroku deployment a piece of cake.
#
# All credit goes to Shinichi Segawa (tektoh) for his implementation, I only
# updated his work to CakePHP 3.2.
#-----------------------------------------------------------------------

# Downloading composer in site dir, so it's available
echo "---------------------------------------------"
echo "- Setting up Composer and Cake dependencies -"
echo "---------------------------------------------"

# Removing existing files:
rm -rf /vagrant/www
cd /vagrant/

# Clone the git repo
sudo -u vagrant git clone ${GIT_CAKE3} /vagrant/www


cd /vagrant/www
# Installing composer
if [ ! -e composer.phar ]; then
  curl -sS https://getcomposer.org/installer | sudo php
  export COMPOSER_PROCESS_TIMEOUT=600
  yes | sudo -u vagrant php composer.phar install --prefer-dist
else
  php composer.phar self-update
  yes | sudo -u vagrant php composer.phar update
fi

# Removed as not part of the box. (I'll leave it here  if we change our minds)
#echo "---------------------------------------------"
#echo "-------- Migrating Beer Plugin DB -----------"
#echo "---------------------------------------------"
# Migrating sample DB
#sudo -u vagrant ./bin/cake migrations migrate -p Beers

echo "---------------------------------------------"
echo "CakePHP3 successfully installed in /vagrant/www"
echo "---------------------------------------------"