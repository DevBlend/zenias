#!/bin/bash

DIRECTORY="fcc-python-vagrant"

echo "This script requires superuser access to install apt packages."
echo "You will be prompted for your password by sudo."

# clear any previous sudo permission
sudo -k

# run inside sudo
sudo sh <<SCRIPT

echo "Installing VirtualBox ..."

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

apt-get update -y
apt-get install -y virtualbox

echo "Installing dkms ..."

apt-get install -y dkms

echo "Installing VirtualBox extensions ..."

wget -O /tmp/Linux_amd64.run http://download.virtualbox.org/virtualbox/5.0.20/VirtualBox-5.0.20-106931-Linux_amd64.run

chmod +x /tmp/Linux_amd64.run
./tmp/Linux_amd64.run

echo "Installing vagrant ..."

apt-get install vagrant

echo "Done Installing. Now cloning repo ..."

if [ -d "$DIRECTORY" ]; then
	echo "Cloning Git repository"
	git clone https://github.com/byteknacker/fcc-python-vagrant.git ~\fcc-python-vagrant
	cd fcc-python-vagrant
	echo "Creating virtual machine"
	vagrant up
fi

echo "Installation done. To start VM, simply run vagrant ssh"

SCRIPT
