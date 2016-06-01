#!/usr/bin/env bash

# installation settings
PROJECT="java_project" # we would want a name passed to it via te first argument, $1
DB="fcc_java_db" # the name of postgreSQL DB we need to provision, maybe $2

# This file is executed by root user - sudo not needed
# But do not create any directory
# which vagrant user might need access to later in su mode
# use su - vagrant -c "" syntax
export DEBIAN_FRONTEND=noninteractive
echo "---------------------------------------------"
echo "Running vagrant provisioning"
echo "---------------------------------------------"

# install heroku toolbelt
echo "-------------- Installing heroku toolbelt -------------------------"
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
# These shell script snippets are directly taken from heroku installation script
# We want to avoid the apt-get update
# add heroku repository to apt
echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
# install heroku's release key for package verification
wget -O- https://toolbelt.heroku.com/apt/release.key 2>&1 | apt-key add -

# add Java 8 ppa, Maven PPA, Gradle PPA
apt-get install -y software-properties-common
add-apt-repository ppa:webupd8team/java
add-apt-repository "deb http://ppa.launchpad.net/natecarlson/maven3/ubuntu precise main"
add-apt-repository ppa:cwchien/gradle

echo "---------------------------------------------"
echo "------- Updating package dependencies -------"
echo "---------------------------------------------"
apt-get update -y # no need for sudo, and -y is needed to bypass the yes-no

echo "---------------------------------------------"
echo "-------- Installing packages ----------------"
echo "---------------------------------------------"
# install gcc and g++ and other build basics to ensure most software works
# install man too
# dos2unix is needed because we could have CR-LF line terminator on Windows
# And that would prevent ~/.bashrc to work properly because \r would be unrecognized
# Ruby needed for heroku toolbelt
# notice that this is not a rigorous Ruby install, where we typically use rvm
apt-get install -y --no-install-recommends heroku-toolbelt build-essential dos2unix man ruby libpq-dev postgresql postgresql-contrib curl
# install the cli
su - vagrant -c "heroku --version > /dev/null 2>&1"

# install Java - 8 and setup configs
apt-get install -y oracle-java8-installer
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# set JAVA environment variables
apt-get install -y oracle-java8-set-default

# install Maven
apt-get install -y --force-yes maven3

# install Gradle
apt-get install -y gradle

# install Tomcat
# Setup Tomcat user
groupadd tomcat
useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
# Download Tomcat
wget http://mirror.sdunix.com/apache/tomcat/tomcat-8/v8.0.23/bin/apache-tomcat-8.0.23.tar.gz
mkdir /opt/tomcat
tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
# Configure Tomcat
su - vagrant <<TOMCAT

cd /opt/tomcat
chgrp -R tomcat conf
chmod g+rwx conf
chmod g+r conf/*
cp /vagrant/tomcat.conf /etc/init/tomcat.conf
initctl reload-configuration
initctl start tomcat

TOMCAT



# install postgresql and setup user
echo "---------------------------------------------"
echo "------- Setting up postgresql ---------------"
echo "---------------------------------------------"
su - postgres -c "createuser -s vagrant"
su - vagrant -c "createdb ${DB}"

echo "---------------------------------------------"
echo "------ Preparing .bashrc for first usage ----"
echo "---------------------------------------------"

# Copy bashrc
#su - vagrant -c "mv /vagrant/.bashrc /home/vagrant/"
# If you are on Windows host, with Git checkout windows line terminator style CRLF
# this comes in handy
su - vagrant -c "dos2unix  /home/vagrant/.bashrc > /dev/null 2>&1"

echo "---------------------------------------------"
echo " Done! Run vagrant ssh to start working "
echo "---------------------------------------------"
