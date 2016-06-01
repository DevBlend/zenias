#!/usr/bin/env bash

# installation settings
PROJECT="my_project" # we would want a name passed to it via te first argument, $1
DB="fcc_provision" # the name of postgreSQL DB we need to provision, maybe $2
ENV_NAME="fcc-ruby" # the vitualenv we would like to create, with Python 3.4

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
# add PPA for up to date Node.js runtime
# notice that this is not a rigorous node  install, where we typically use npm
add-apt-repository ppa:chris-lea/node.js
apt-get --ignore-missing --no-install-recommends install build-essential \
curl openssl libssl-dev libcurl4-openssl-dev zlib1g zlib1g-dev libreadline-dev \
libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev libsqlite3-0 sqlite3  \
libxml2-dev libxslt1-dev python-software-properties libffi-dev libgdm-dev  \
libncurses5-dev automake autoconf libtool bison postgresql postgresql-contrib \
libpq-dev pgadmin3 libc6-dev nodejs man dos2unix heroku-toolbelt  -y

# install the cli
su - vagrant -c "heroku --version > /dev/null 2>&1"

# install postgresql and setup user
echo "---------------------------------------------"
echo "------- Setting up postgresql ---------------"
echo "---------------------------------------------"
su - postgres -c "createuser -s vagrant"
su - vagrant -c "createdb ${DB}"

echo "---------------------------------------------"
echo "------ Preparing .bashrc for first usage ----"
echo "---------------------------------------------"
# set up virtualenvwrapper and add code to properly
# activate virtualenvwrapper
# echo "WORKON_HOME=\"/home/vagrant/.virtualenvs\"" >> /home/vagrant/.bashrc
# echo "source /usr/local/bin/virtualenvwrapper.sh > /dev/null 2>&1" >> /home/vagrant/.bashrc

echo "---------------------------------------------"
echo "------ Creating Ruby environment --------"
echo "---------------------------------------------"
# Remember to run in vagrant user mode
# Otherwise, the user would not be able to run pip install without sudo
# su - vagrant -c "/usr/local/bin/virtualenv /home/vagrant/.virtualenvs/${ENV_NAME} --python=/usr/bin/python3 && \
#     /home/vagrant/.virtualenvs/${ENV_NAME}/bin/pip install -r /vagrant/requirements.txt"

# install rbenv
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
# install ruby_build
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile

# ditch the docs
export RUBY_CONFIGURE_OPTS=--disable-install-doc ruby-build ...

rbenv install -v 3.2.1
rbenv global 3.2.1

#echo "gem: --no-document" > ~/.gemrc
#gem install bundler
#gem install rails

# Whenever you install a new version of Ruby or a gem that provides commands,
# you should run the rbenv rehash sub-command. This will install shims for all
# Ruby executables known to rbenv, which will allow you to use the executables.
rbenv rehash

su - vagrant -c "mv /vagrant/.bashrc /home/vagrant/"
su - vagrant -c "mkdir /home/vagrant/.configs"
su - vagrant -c "mv /vagrant/zeus /home/vagrant/.configs/zeus"
# If you are on Windows host, with Git checkout windows line terminator style CRLF
# this comes in handy
su - vagrant -c "dos2unix  /home/vagrant/.bashrc > /dev/null 2>&1"

# Activate the virtualenv on first login
echo "workon ${ENV_NAME}" >> /home/vagrant/.bashrc

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"
