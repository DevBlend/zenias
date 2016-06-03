#!/bin/bash -
#title          :zeus.sh
#description    :Zeus - Vagrant boxes with Heroku integration
#author         :mtancoigne
#date           :20160602
#version        :0.1
#usage          :./zeus.sh
#notes          :
#bash_version   :4.3.42(1)-release
#============================================================================
export Z_VERSION="0.1"

# Logo
z_logo() {
  cat << EOF


         (    (
   (    ))\  ))\  (    Zeus: Vagrant boxes with Heroku integration
   )\  /((_)/((_) )\\
  ((_)(_)) (_))( ((_)  A FreeCodeCamp project (http://freecodecamp.com)
  |_ // -_)| || |(_-<
  /__|\___| \_,_|/__/  v ${Z_VERSION}


EOF
}


# Help
z_help() {
  cat << EOF
Usage: zeus -l <language> -d <destination> [-o <options> -g -h ]

For more information, refer to the README.

Report bugs at: https://github.com/alayek/zeus/issues

EOF
}

# Error function: returns an error message and exits.
z_error() {
  cat << EOF


ERROR: ${1}

$(z_help)


EOF
exit 1
}

#
# WARNING, THIS IS MEANT TO BE RUN IN THE GUEST.
#
gitconfig () {
  if [ "${Z_GITHUB_CRED}" == true ]; then
    echo "-----------------------------------------------------"
    echo "Please, enter your github credentials."
    echo "If you don't want to configure a github account, use "
    echo "the -g option when you launch this script."
    echo ""
    # Ask user for input to set up GitHub and git configs.
    read -p " - What is your real name?" username
    read -p " - What is your Github email address?" email
    read -p " - What is your Github username?" githubusername
    git config --global user.email "$email"
    git config --global user.name "$username"
    # Set push to simple
    git config --global push.default simple
    # Store the GitHub username inside github_config so that gitcreate
    # can retrieve the username to perform Github API call
    echo "githubusername: $githubusername" >> /home/vagrant/.configs/github_config
  else
    echo "... Skipping Github configuration"
  fi
}

#
# WARNING, THIS IS MEANT TO BE RUN IN THE GUEST.
#
gitcreate () {
  if [ "${Z_GITHUB_CRED}" == true ] && [ "${Z_GITHUB_NEWREPO}" == true ]; then
    cd "${V_WORKING_DIR}"
    # Create a private or public repo on Github
    echo "-----------------------------------------------------"
    echo "A new github repo will be created."
    echo "If you don't want to create a new repo, use the -n"
    echo "option when you launch this script."
    echo ""
    read -p "How should the Github remote repo be called? " remoterepo
    # Get the stored GitHub username inside github_config
    githubname=$(cat ~/.configs/github_config | egrep "githubusername" | tail -1 | awk '{print $2}')
    # Loop to create the remote repo
    case $zeusargv2 in
        private)
            curl -u "$githubname" https://api.github.com/user/repos -d '{"name":'"\"$remoterepo\""',"private":"true"}'
            ;;
        public)
            curl -u "$githubname" https://api.github.com/user/repos -d '{"name":'"\"$remoterepo\""'}'
            ;;
    esac
  else
    echo "... Skipping creation of a new repo on github."
    echo "... Initializing a new git repo."
    cd "${V_WORKING_DIR}"
    git init
  fi
}

#
# WARNING, THIS IS MEANT TO BE RUN IN THE GUEST.
#
herokuconfig () {
  if [ "${Z_HEROKU_CRED}" == true ]; then
    echo "-----------------------------------------------------"
    echo "Please, enter your Heroku credentials."
    echo "If you don't want to configure a Heroku account, use "
    echo "the -h option when you launch this script."
    echo ""
    heroku login

  else
    echo "... Skipping Heroku login configuration"
  fi
}

#
# WARNING, THIS IS MEANT TO BE RUN IN THE GUEST.
#
herokucreate () {
  if [ "${Z_HEROKU_CRED}" == true ] && [ "${Z_HEROKU_NEWMACHINE}" == true ]; then
    echo "-----------------------------------------------------"
    echo "A new Heroku machine will be created."
    echo "If you don't want to create a new machine, use the -c"
    echo "option when you launch this script."
    echo ""
    cd "${V_WORKING_DIR}"
    heroku create
  else
    echo "... Skipping creation of a new machine on Heroku."
  fi
}



# Will ask for github credentials
export Z_GITHUB_CRED=true
export Z_GITHUB_NEWREPO=true
# Will ask for Heroku credentials
export Z_HEROKU_CRED=true
export Z_HEROKU_NEWMACHINE=true

# Getting the params:
while getopts ":l:d:o:ghn" opt; do
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
    \?) z_error "Invalid option -$OPTARG"
    ;;
    :) z_error "Option -$OPTARG requires an argument."
    ;;
  esac
done

# Display the wonderful logo
echo "$(z_logo)"

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

echo "-----------------------------------------------------"
echo "Preparing a vagrant box for ${Z_LANGUAGE} language..."
# Copy all the files
cp -r ./${Z_LANGUAGE}/* "${Z_DESTINATION}/"
cd "${Z_DESTINATION}"

# Vagrant up
vagrant up
# Vagrant up will launch the Vagrantfile, wich will launch provision.sh
# The provision script should have a call to:
# gitconfig, gitcreate, herokuconfig and herokucreate

vagrant ssh
