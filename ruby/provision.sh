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
sudo sh -c "echo deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu trusty main  >> /etc/apt/sources.list.d/chris-lea-node_js-trusty.list"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12
sudo sh -c "echo deb http://toolbelt.heroku.com/ubuntu ./ >> /etc/apt/sources.list.d/heroku.list"
wget -q -O- https://toolbelt.heroku.com/apt/release.key | sudo apt-key add -

sudo apt-get update -y

echo "---------------------------------------------"
echo "-------- Installing packages ----------------"
echo "---------------------------------------------"
# install gcc and g++ and other build basics to ensure most software works
# install man
# dos2unix is needed because we could have CR-LF line terminator on Windows
# And that would prevent ~/.bashrc to work properly because \r would be unrecognized
# add PPA for up-to-date Node.js runtime
# notice that this is not a rigorous node  install, where we typically use npm

sudo apt-get --ignore-missing --no-install-recommends install build-essential \
curl openssl libssl-dev libcurl4-openssl-dev zlib1g zlib1g-dev libreadline-dev \
libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev libsqlite3-0 sqlite3  \
libxml2-dev libxslt1-dev  libffi-dev libgdm-dev  \
libncurses5-dev automake autoconf libtool bison postgresql postgresql-contrib \
libpq-dev pgadmin3 libc6-dev man dos2unix heroku-toolbelt nodejs -y

# install postgresql and setup user
echo "---------------------------------------------"
echo "------- Setting up postgresql ---------------"
echo "---------------------------------------------"
sudo su - postgres -c "createuser -s vagrant"
createdb ${DB}

echo "---------------------------------------------"
echo "------ Creating Ruby environment --------"
echo "---------------------------------------------"

# download and extract ruby 2.3.1
mkdir ~/.rubies
cd ~/.rubies
wget -q -O ruby-2.3.1.tar.bz2 http://rubies.travis-ci.org/ubuntu/14.04/x86_64/ruby-2.3.1.tar.bz2
tar -xjf ruby-2.3.1.tar.bz2
rm ruby-2.3.1.tar.bz2
cd ~

#install chruby
wget -q -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzf chruby-0.3.9.tar.gz
cd chruby-0.3.9
sudo ./scripts/setup.sh
cd ~
rm -rf chruby-0.3.9 chruby-0.3.9.tar.gz
echo 'chruby 2.3.1' >> ~/.bashrc

#install ruby-install
wget -q -O ruby-install-0.6.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz
tar -xzf ruby-install-0.6.0.tar.gz
cd ruby-install-0.6.0
sudo make install
cd ~
rm -rf ruby-install-0.6.0 ruby-install-0.6.0.tar.gz

# backup and mod our .bashrc
sed -i".bak" '6,11d' .bashrc
