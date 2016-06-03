#!/bin/bash -
#title          :zeus_guest_scripts.sh
#description    :Zeus - Vagrant boxes with Heroku integration
#author         :mtancoigne
#date           :20160602
#version        :0.1
#usage          :./zeus.sh
#notes          :
#bash_version   :4.3.42(1)-release
#============================================================================
# Logo
export Z_VERSION="0.1"
z_logo() {
  cat << EOF
\n
\n
\e[31m         (    (
\e[31m   (    ))\  ))\  (    \e[39mZeus: Vagrant boxes with Heroku integration
\e[31m   )\  /(\e[33m(_)\e[31m/(\e[33m(_) )\\
\e[31m  (\e[33m(_)(_)\e[31m) \e[33m(_)\e[31m)( (\e[33m(_)    \e[32mA FreeCodeCamp project (http://freecodecamp.com)
\e[32m  |_ // -_)| || |(_-<
\e[32m  /__|\___| \_,_|/__/  \e[39mv ${Z_VERSION}
\n
\n
EOF
}

#
# WARNING, THIS IS MEANT TO BE RUN IN THE GUEST.
#
gitconfig () {
  if [ "${Z_GITHUB_CRED}" == true ]; then
    echo -----------------------------------------------------------------------
    echo "Please, enter your github credentials."
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
    echo -----------------------------------------------------------------------
    echo "A new github repo will be created."
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
    echo -----------------------------------------------------------------------
    echo "Please, enter your Heroku credentials."
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
    echo -----------------------------------------------------------------------
    echo "A new Heroku machine will be created."
    echo ""
    cd "${V_WORKING_DIR}"
    heroku create
  else
    echo "... Skipping creation of a new machine on Heroku."
  fi
}


# Github
while true; do
    read -p "Do you want to login to Github? [y/n]" yn
    case $yn in
        [Yy]* )
        gitconfig
        while true; do
            read -p "Do you want to create a new Github repository? [y/n]" yn
            case $yn in
                [Yy]* )
                gitcreate
                break;;
                [Nn]* ) break;;
                * ) echo "Please answer y or n.";;
            esac
        done
        break;;
        [Nn]* ) break;;
        * ) echo "Please answer y or n.";;
    esac
done

# Heroku
while true; do
    read -p "Do you want to login to Heroku? [y/n]" yn
    case $yn in
        [Yy]* )
        herokuconfig
        while true; do
            read -p "Do you want to create a new machine on Heroku? [y/n]" yn
            case $yn in
                [Yy]* )
                herokucreate
                break;;
                [Nn]* ) break;;
                * ) echo "Please answer y or n.";;
            esac
        done
        break;;
        [Nn]* ) break;;
        * ) echo "Please answer y or n.";;
    esac
done

echo ""
echo "All done."
