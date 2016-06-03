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
#sudo apt-get update -y # no need for sudo, and -y is needed to bypass the yes-no
#sudo apt-get install python-software-properties software-properties-common -y

#sudo add-apt-repository -y ppa:chris-lea/node.js
sudo sh -c "echo deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu trusty main  >> /etc/apt/sources.list.d/chris-lea-node_js-trusty.list"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12
#sudo add-apt-repository -y 'deb http://toolbelt.heroku.com/ubuntu ./' -k 'https://toolbelt.heroku.com/apt/'
sudo sh -c "echo deb http://toolbelt.heroku.com/ubuntu ./ >> /etc/apt/sources.list.d/heroku.list"
wget -q -O- https://toolbelt.heroku.com/apt/release.key | sudo apt-key add -

echo "-------------hmmmmm--------------------------"
sudo apt-get update -y

#find /etc/apt/sources.list.d -type f -name '*.list' -exec sudo apt-get update -o Dir::Etc::sourcelist="{}" ';'
# sudo apt-get update -o Dir::Etc::sourcelist="sources.list.d/chris-lea-node_js-trusty.list" \
#     -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
# sudo apt-get update -o Dir::Etc::sourcelist="sources.list.d/heroku.list" \
#     -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"

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

# # no rdoc for installed gems
# sudo -u vagrant echo 'gem: --no-ri --no-rdoc' >> /home/vagrant/.gemrc

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



# install nodejs and heroku
echo "-------------- Installing heroku toolbelt -------------------------"

# add heroku repository to apt
#sudo echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
# install heroku's release key for package verification
# add up-to-date nodejs ppa
# echo "---adaptrepo"
# sudo add-apt-repository ppa:chris-lea/node.js -y
# sudo add-apt-repository 'deb http://toolbelt.heroku.com/ubuntu ./' -y
# echo "---wget"
# curl https://toolbelt.heroku.com/apt/release.key | sudo apt-key add -
#
# echo "---update"
# sudo apt-get update
# echo "---install"
# sudo apt-get install heroku-toolbelt nodejs -y
# echo "--- aptd done"
#




#back up our .bashrc
mv ~/.bashrc ~/.bashrc.bak
#copy in our modified .bashrc
cp /vagrant/bashfix ~/.bashrc
dos2unix ~/.bashrc

# # install a couple of common gems
# gem install bundler -v '~> 1.12'
# gem install rspec -v '~> 3.4'
# gem install rails -v '~>4.2'
# gem install sinatra -v '~> 1.4'
#
# # If you are on Windows host, with Git checkout windows line terminator style CRLF
# # this comes in handy
# dos2unix  /home/vagrant/.bashrc > /dev/null 2>&1
#
# sudo add-apt-repository ppa:chris-lea/node.js -y
# sudo apt-get install heroku-toolbelt nodejs -y
#
# # install heroku toolbelt
# #echo "-------------- Installing heroku toolbelt -------------------------"
# # These shell script snippets are directly taken from heroku installation script
# # We want to avoid the apt-get update
# # add heroku repository to apt
# #echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
# # install heroku's release key for package verification
# #wget -O- https://toolbelt.heroku.com/apt/release.key 2>&1 | apt-key add -
# # install the cli
# #heroku --version > /dev/null 2>&1
#
# echo "---------------------------------------------"
# echo " Done! Run vagrant ssh to start working "
# echo "---------------------------------------------"
