#!/usr/bin/env bash


echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc

# install a couple of common gems
gem install bundler -v '~> 1.12'
gem install rspec -v '~> 3.4'
gem install rails -v '~>4.2'
gem install sinatra -v '~> 1.4'

# If you are on Windows host, with Git checkout windows line terminator style CRLF
# this comes in handy
#dos2unix  /home/vagrant/.bashrc > /dev/null 2>&1

sudo add-apt-repository ppa:chris-lea/node.js -y
sudo apt-get install heroku-toolbelt nodejs -y

# install heroku toolbelt
#echo "-------------- Installing heroku toolbelt -------------------------"
# These shell script snippets are directly taken from heroku installation script
# We want to avoid the apt-get update
# add heroku repository to apt
#echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
# install heroku's release key for package verification
#wget -O- https://toolbelt.heroku.com/apt/release.key 2>&1 | apt-key add -
# install the cli
#heroku --version > /dev/null 2>&1

mv ~/.bashrc.bak ~/.bashrc
echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"

exit
