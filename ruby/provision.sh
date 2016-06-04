#!/usr/bin/env bash

# installation settings
DB="fcc_provision" # the name of postgreSQL DB we need to provision, maybe $2

export DEBIAN_FRONTEND=noninteractive
echo "---------------------------------------------"
echo "Running vagrant provisioning"
echo "---------------------------------------------"

echo "---------------------------------------------"
echo "------- Updating package dependencies -------"
echo "------------ And adding repos ---------------"
echo "---------------------------------------------"
# we don't need a proper node install for rails so we use this repo
sudo sh -c "echo deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu trusty main  >> /etc/apt/sources.list.d/chris-lea-node_js-trusty.list"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12
# add heroku repo
sudo sh -c "echo deb http://toolbelt.heroku.com/ubuntu ./ >> /etc/apt/sources.list.d/heroku.list"
wget -q -O- https://toolbelt.heroku.com/apt/release.key | sudo apt-key add -
# update our packages lists
sudo apt-get -y update

echo "---------------------------------------------"
echo "-Downloading and Installing packages ~117MiB "
echo "---------------------------------------------"
# install all of our dependencies and a few conveniences
sudo apt-get -y --ignore-missing --no-install-recommends install build-essential \
curl openssl libssl-dev libcurl4-openssl-dev zlib1g zlib1g-dev libreadline-dev \
libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev libsqlite3-0 sqlite3  \
libxml2-dev libxslt1-dev  libffi-dev libgdm-dev libncurses5-dev automake autoconf libtool bison postgresql postgresql-contrib \
libpq-dev pgadmin3 libc6-dev man dos2unix heroku-toolbelt nodejs libqtwebkit-dev \
gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

# install postgresql and setup user
echo "---------------------------------------------"
echo "------- Setting up postgresql ---------------"
echo "---------------------------------------------"
sudo su - postgres -c "createuser -s vagrant"
createdb ${DB}

echo "---------------------------------------------"
echo "------ Creating Ruby environment ------------"
echo "---------------------------------------------"

echo "---------------------------------------------"
echo "-- Downloading Ruby 2.3.1 25.15 MiB ---------"
echo "---------------------------------------------"
# download ruby 2.3.1
mkdir ~/.rubies
cd ~/.rubies
wget -q -O ruby-2.3.1.tar.bz2 http://rubies.travis-ci.org/ubuntu/14.04/x86_64/ruby-2.3.1.tar.bz2

echo "---------------------------------------------"
echo "--------- Extracting Ruby 2.3.1 -------------"
echo "---------------------------------------------"
# extract ruby 2.3.1
tar -xjf ruby-2.3.1.tar.bz2
rm ruby-2.3.1.tar.bz2
cd ~

echo "---------------------------------------------"
echo "------------ Installing chruby --------------"
echo "---------------------------------------------"
#install chruby
wget -q -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzf chruby-0.3.9.tar.gz
cd chruby-0.3.9
sudo ./scripts/setup.sh 2>&1
cd ~
rm -rf chruby-0.3.9 chruby-0.3.9.tar.gz
echo "chruby 2.3.1 > /dev/null 2>&1" >> ~/.bashrc

echo "---------------------------------------------"
echo "--------- Installing ruby-install -----------"
echo "---------------------------------------------"
#install ruby-install
wget -q -O ruby-install-0.6.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz
tar -xzf ruby-install-0.6.0.tar.gz
cd ruby-install-0.6.0
sudo make install
cd ~
rm -rf ruby-install-0.6.0 ruby-install-0.6.0.tar.gz

# backup and mod our .bashrc
sed -i".bak" '6,11d' .bashrc
