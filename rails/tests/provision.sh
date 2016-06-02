#!/usr/bin/env bash

#install bats
#this is not ran in the provisioner
git clone https://github.com/sstephenson/bats.git ~/.bats
cd ~/.bats
sudo ./install.sh /usr/local
cd ~
