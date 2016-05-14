#!/bin/bash

DIRECTORY="fcc-python-vagrant"
ARCH="$(uname -m)"
OS="$(cat /etc/os-release | grep ID_LIKE)"

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

#wget -O /tmp/Linux_amd64.run http://download.virtualbox.org/virtualbox/5.0.20/VirtualBox-5.0.20-106931-Linux_amd64.run

#chmod +x /tmp/Linux_amd64.run
#/tmp/Linux_amd64.run

echo "Installing vagrant ..."

InstallVagrant() {
	if [ "$OSTYPE" = "darwin" ]; then
		wget -O /tmp/vagrant.dmg https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1.dmg
		hdiutil attach /tmp/vagrant.dmg
		cd /Volumes/vagrant
		installer -pkg vagrant.pkg -target "/"
		hdiutil detach /Volumes/vagrant/
	else
		case $OS in
			"ID_LIKE=debian")
				case $ARCH in
					"x86_64") wget -O /tmp/vagrant.deb https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb ;;
					"i386") wget -O /tmp/vagrant.deb https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_i686.deb ;;
				esac
				dpkg -i /tmp/vagrant.deb
			;;
			"ID_LIKE=rhel fedora")
				case $ARCH in
					"x86_64") wget -O /tmp/vagrant.rpm https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.rpm ;;
					"i386") wget -O /tmp/vagrant.rpm https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.rpm ;;
				esac
				rpm -Uvh /tmp/vagrant.rpm
			;;
		esac
	fi
}

if hash vagrant 2>/dev/null; then
	echo "Vagrant already installed, skipping ..."
else
	InstallVagrant
fi

SCRIPT

echo "Done Installing. Now cloning repo ..."

if [ -d "$DIRECTORY" ]; then
	echo "Cloning Git repository"
	git clone https://github.com/byteknacker/fcc-python-vagrant.git ~\$DIRECTORY
	cd $DIRECTORY
else
	echo "Repository present. updating ..."
	git pull
fi

echo "Creating virtual machine"
#vagrant up
echo "Installation done. To start VM, simply run vagrant ssh"