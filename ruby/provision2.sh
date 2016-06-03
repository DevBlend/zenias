#!/usr/bin/env bash

chruby 2.3.1
echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc

# install a couple of common gems
gem install bundler -v '~> 1.12'
gem install rspec -v '~> 3.4'
gem install rails -v '~>4.2'
gem install sinatra -v '~> 1.4'

# If you are on Windows host, with Git checkout windows line terminator style CRLF
# this comes in handy
#dos2unix  /home/vagrant/.bashrc > /dev/null 2>&1



# restore our original .bashrc
mv ~/.bashrc.bak ~/.bashrc
echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"

exit
