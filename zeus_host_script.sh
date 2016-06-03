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
# Will ask for github credentials
export Z_GITHUB_CRED=true
export Z_GITHUB_NEWREPO=true
# Will ask for Heroku credentials
export Z_HEROKU_CRED=true
export Z_HEROKU_NEWMACHINE=true
export Z_STATE='host'

# Getting the params:
while getopts ":l:d:o:ghncz" opt; do
  case $opt in
    l) export Z_LANGUAGE="$OPTARG"
    ;;
    d) export Z_DESTINATION="$OPTARG"
    ;;
    o) export Z_OPTION="$OPTARG"
    ;;
    g) Z_GITHUB_CRED=false
    ;;
    h) Z_HEROKU_CRED=false
    ;;
    n) Z_GITHUB_NEWREPO=false
    ;;
    c) Z_HEROKU_NEWMACHINE=false
    ;;
    z) Z_STATE="GUEST"
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

echo '-----------------------------------------------------------------------'
echo ''
echo "Preparing a vagrant box for ${Z_LANGUAGE} language..."
echo ''
echo '-----------------------------------------------------------------------'
echo ' - Copying box files'
# Copy all the files
cp -r ./${Z_LANGUAGE}/* ${Z_DESTINATION}/

echo ' - Merging provision.sh with Zeus files'
# Copy the functions
cat ./zeus.sh > ${Z_DESTINATION}/vagrant/zeus_guest.sh
# Export config
z_export >> ${Z_DESTINATION}/vagrant/zeus_guest.sh
# Merge
cat ${Z_DESTINATION}/vagrant/zeus_guest.sh ${Z_DESTINATION}/vagrant/provision.sh > ${Z_DESTINATION}/vagrant/provision.sh.tmp
mv ${Z_DESTINATION}/vagrant/provision.sh.tmp ${Z_DESTINATION}/vagrant/zeus_guest.sh

# Creating script for GH/Heroku credentials
credfile=${Z_DESTINATION}/vagrant/zeus_credentials.sh
z_export > ${credfile}
cat zeus_guest_scripts.sh >> ${credfile}

echo ' - Preparing zeus_credentials.sh'
if [ ${Z_GITHUB_CRED} == true ]; then
  echo "gitconfig" >> ${credfile}
  if [ ${Z_GITHUB_NEWREPO} == true ]; then
    echo "gitcreate" >> ${credfile}
  else
    echo "  ...Skipping Github repository creation"
  fi
else
  echo "  ...Skipping Github configuration"
fi

if [ ${Z_HEROKU_CRED} == true ]; then
  echo "herokuconfig" >> ${credfile}
  if [ ${Z_GITHUB_NEWREPO} == true ]; then
    echo "herokucreate" >> ${credfile}
  else
    echo "  ...Skipping Heroku machine creation"
  fi
else
  echo "  ...Skipping Heroku configuration"
fi

# Updating rights
chmod +x ${Z_DESTINATION}/vagrant/*
cd "${Z_DESTINATION}"

echo ''
echo '-----------------------------------------------------------------------'
echo "Launching Vagrant"
echo '-----------------------------------------------------------------------'
vagrant up

#vagrant ssh
