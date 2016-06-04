#!/usr/bin/env bash

# where we're going we don't need docs
echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc

echo "---------------------------------------------"
echo " ------------ Installing Gems--------------- "
echo "---------------------------------------------"
# install a couple of common gems
echo "------------bundler--------------------------"
gem install bundler -q -v '~> 1.12'
echo "------------rails----------------------------"
gem install rails -q -v '~>4.2'
echo "------------rspec----------------------------"
gem install rspec -q -v '~> 3.4'
echo "------------sinatra--------------------------"
gem install sinatra -q -v '~> 1.4'

# restore our original .bashrc
mv ~/.bashrc.bak ~/.bashrc

# take the redirect off of chruby
sed -i '$ d' .bashrc
echo "chruby 2.3.1" >> ~/.bashrc

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working      "
echo "---------------------------------------------"

exit
