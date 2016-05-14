#!/bin/bash

DIRECTORY="fcc-python-vagrant"

echo "This script requires superuser access to install apt packages."
echo "You will be prompted for your password by sudo."

# clear any previous sudo permission
sudo -k

# run inside sudo
sudo sh <<SCRIPT

echo "Installing VirtualBox ..."

if hash virtualbox 2>/dev/null; then
	echo "Virtualbox already installed, skipping ..."
else
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
	wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -

	apt-get update -y
	apt-get install -y virtualbox
fi

echo "Installing dkms ..."
if hash dkms 2>/dev/null; then
	echo "Dkms already installed, skipping ..."
else
	apt-get install -y dkms
fi

echo "Installing VirtualBox extensions ..."

wget -O /tmp/Linux_amd64.run http://download.virtualbox.org/virtualbox/5.0.20/VirtualBox-5.0.20-106931-Linux_amd64.run

chmod +x /tmp/Linux_amd64.run
./tmp/Linux_amd64.run

echo "Installing vagrant ..."

if hash vagrant 2>/dev/null; then
	echo "Vagrant already installed, skipping ..."
else
	apt-get install vagrant
fi

echo "Done Installing. Now cloning repo ..."

if [ -d "$DIRECTORY" ]; then
	echo "Cloning Git repository"
	git clone https://github.com/byteknacker/fcc-python-vagrant.git ~\fcc-python-vagrant
	cd $DIRECTORY
else
	echo "Repository present. updating ..."
	git pull
fi

SCRIPT

echo "Creating virtual machine"
vagrant up
echo "Installation done. To start VM, simply run vagrant ssh"