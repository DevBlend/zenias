#!/bin/bash -
#title          :zeus_host_script.sh
#description    :Zeus - Vagrant boxes with Heroku integration
#author         :mtancoigne
#date           :20160602
#version        :0.1
#usage          :./zeus.sh
#notes          :
#bash_version   :4.3.42(1)-release
#============================================================================
export Z_VERSION="0.1"
source ./zeus_host_functions.sh

# Getting the params:
while getopts ":l:d:o:ghncz" opt; do
  case $opt in
    l) export Z_LANGUAGE="$OPTARG"
    ;;
    d) export Z_DESTINATION="$OPTARG"
    ;;
    o) export Z_OPTION="$OPTARG"
    ;;
    \?) z_error "Invalid option -$OPTARG"
    ;;
    :) z_error "Option -$OPTARG requires an argument."
    ;;
  esac
done

# Display the wonderful logo
echo -e "$(z_logo)"

# Current directory
export Z_DIR=$(pwd)

# No language or destination
if [ "${Z_LANGUAGE}" == '' ] || [ "${Z_DESTINATION}" == '' ];then
  z_error "You should at least provide a language and a destination."
fi

# Language does not exist
if [ ! -d "${Z_DIR}/${Z_LANGUAGE}" ] || [ "${Z_LANGUAGE}" == 'common' ]; then
  z_error "Language '${Z_LANGUAGE}' not found"
fi

# Destination exists
if [ -d "${Z_DESTINATION}" ]; then
  # Destination is not empty
  if  [ "$(ls -A ${Z_DESTINATION})" ]; then
    z_error "Directory '${Z_DESTINATION}' is not empty."
  fi
else
  mkdir "${Z_DESTINATION}"
fi

echo '---------------------------------------------------------------------------'
echo ''
echo "Preparing a vagrant box for ${Z_LANGUAGE} language..."
echo ''
echo '---------------------------------------------------------------------------'
echo ' - Copying box files'
# Copy all the files
cp -r ./${Z_LANGUAGE}/* ${Z_DESTINATION}/

echo ' - Passing options to provision'
# Copy the functions
echo 'export Z_OPTION='${Z_OPTION} > ${Z_DESTINATION}/vagrant/_provision_vars.sh

# Creating script for GH/Heroku credentials
credfile=${Z_DESTINATION}/vagrant/zeus_credentials.sh
cp zeus_guest_scripts.sh ${Z_DESTINATION}/vagrant/zeus_credentials.sh

# Updating rights
chmod +x ${Z_DESTINATION}/vagrant/*
cd "${Z_DESTINATION}"

echo ''
echo '---------------------------------------------------------------------------'
echo "Launching Vagrant"
echo '---------------------------------------------------------------------------'
vagrant up

#vagrant ssh
