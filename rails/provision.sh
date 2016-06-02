#!/usr/bin/env bash

# installation settings
DB="fcc_provision" # the name of postgreSQL DB we need to provision, maybe $2

export DEBIAN_FRONTEND=noninteractive
echo "---------------------------------------------"
echo "Running vagrant provisioning"
echo "---------------------------------------------"

# install heroku toolbelt
echo "-------------- Installing heroku toolbelt -------------------------"
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
# install man
# dos2unix is needed because we could have CR-LF line terminator on Windows
# And that would prevent ~/.bashrc to work properly because \r would be unrecognized
# add PPA for up-to-date Node.js runtime
# notice that this is not a rigorous node  install, where we typically use npm
add-apt-repository ppa:chris-lea/node.js -y
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
echo "------ Creating Ruby environment --------"
echo "---------------------------------------------"
# install rbenv and ruby-build
sudo -u vagrant -H git clone git://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
sudo -u vagrant echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.profile
sudo -u vagrant echo 'eval "$(rbenv init -)"' >> /home/vagrant/.profile
sudo -u vagrant -H git clone git://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build

# no rdoc for installed gems
sudo -u vagrant echo 'gem: --no-ri --no-rdoc' >> /home/vagrant/.gemrc

# install ruby and set global version
sudo -u vagrant -i rbenv install 2.3.1
sudo -u vagrant -i rbenv global 2.3.1
# a couple of common gems
sudo -u vagrant -i gem install bundler -v '~> 1.12'
sudo -u vagrant -i gem install rspec -v '~> 3.4'
sudo -u vagrant -i gem install rails -v '~>4.2'
sudo -u vagrant -i gem install sinatra -v '~> 1.4'
# Whenever you install a new version of Ruby or a gem that provides commands,
# you should run the rbenv rehash sub-command. This will install shims for all
# Ruby executables known to rbenv, which will allow you to use the executables.
sudo -u vagrant -i rbenv rehash

# If you are on Windows host, with Git checkout windows line terminator style CRLF
# this comes in handy
su - vagrant -c "dos2unix  /home/vagrant/.bashrc > /dev/null 2>&1"

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"
