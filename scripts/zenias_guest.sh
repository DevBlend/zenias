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
source _provision_vars.sh

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
  echo -----------------------------------------------------------------------
  echo "Please, enter your github credentials."
  echo ""
  # Ask user for input to set up GitHub and git configs.
  read -p " - What is your real name? " username
  read -p " - What is your Github email address? " email
  read -p " - What is your Github username? " githubusername
  git config --global user.email "$email"
  git config --global user.name "$username"
  # Set push to simple
  git config --global push.default simple
  # Store the GitHub username inside github_config so that gitcreate
  # can retrieve the username to perform Github API call
  [ ! -d /home/vagrant/.configs ] && mkdir /home/vagrant/.configs
  echo "githubusername: $githubusername" >> /home/vagrant/.configs/github_config
}

#
# WARNING, THIS IS MEANT TO BE RUN IN THE GUEST.
# @TODO FIX IT
gitcreate () {
  # Destination exists
  if [ -d "${V_WORKING_DIR}" ]; then
    # Destination is not empty
    if  [ "$(ls -A ${V_WORKING_DIR})" ]; then
      echo ""
      echo -e "\e[31mERROR: Future git directory '${V_WORKING_DIR}' is not empty.\e[39m"
      echo ""
      exit
    fi
  else
    mkdir "${V_WORKING_DIR}"
  fi

  cd "${V_WORKING_DIR}"
  # Create a private or public repo on Github
  echo -----------------------------------------------------------------------
  echo "A new github repo will be created in ${V_WORKING_DIR}."
  echo ""
  read -p "How should the Github remote repo be called? " remoterepo
  read -p "Is this repo private or public ? [private/public]" repotype
  # Get the stored GitHub username inside github_config
  githubname=$(cat ~/.configs/github_config | egrep "githubusername" | tail -1 | awk '{print $2}')
  cd ${V_WORKING_DIR}
  git init
  # Loop to create the remote repo
  case $repotype in
      private)
        curl -s -u "$githubname" https://api.github.com/user/repos -d '{"name":'"\"$remoterepo\""',"private":"true"}' > ~/.configs/.githubremote
        newgithubremote=$(cat ~/.configs/.githubremote | egrep "html_url" | tail -1 | awk '{print $2}' | sed -r 's/[",]//g')
        git remote add origin $newgithubremote
        git push --set-upstream origin master
        ;;
      public)
        curl -s -u "$githubname" https://api.github.com/user/repos -d '{"name":'"\"$remoterepo\""'}' > ~/.configs/.githubremote
        newgithubremote=$(cat ~/.configs/.githubremote | egrep "html_url" | tail -1 | awk '{print $2}' | sed -r 's/[",]//g')
        git remote add origin $newgithubremote
        git push --set-upstream origin master
        ;;
  esac
  #repo=$(echo "${answer}"|jq '.clone_url')
  #echo "The repo ${repo} will be cloned in ${V_WORKING_DIR}."
  #git clone "${repo}" "${V_WORKING_DIR}"
}

#
# WARNING, THIS IS MEANT TO BE RUN IN THE GUEST.
#
herokuconfig () {
  echo -----------------------------------------------------------------------
  echo "Please, enter your Heroku credentials."
  echo ""
  heroku login
}

#
# WARNING, THIS IS MEANT TO BE RUN IN THE GUEST.
#
herokucreate () {
  echo -----------------------------------------------------------------------
  echo "A new Heroku machine will be created."
  echo ""
  cd "${V_WORKING_DIR}"
  heroku create
}

echo -e "$(z_logo)"

# Github

doCredentials=true
canCreateRepo=false
canDoAMachine=false
# Login already done
if [ -f /home/vagrant/.configs/github_config ]; then
  read -p "Overwrite your existing credentials ? [y/n]" yn
  while true; do
    case $yn in
        [Yy]* )
          echo "Ok, then..."
          break;;
        [Nn]* )
          echo "Ok, next step..."
          doCredentials=false
          canCreateRepo=true
          break;;
        * ) echo "Please answer y or n.";;
    esac
  done
  echo ""
fi

# Propose login
if [ "${doCredentials}" == true ]; then
  read -p "Do you want to login to Github? [y/n]" yn
  case $yn in
    [Yy]* )
      gitconfig
      canCreateRepo=true
      break;;
    [Nn]* )
      canCreateRepo=false
      break;;
    * ) echo "Please answer y or n.";;
  esac
  echo ""
fi

# Repo creation
if [ "${canCreateRepo}" == true ]; then
  while true; do
    read -p "Do you want to create a new Github repository? [y/n]" yn
    case $yn in
      [Yy]* )
        gitcreate
        break;;
      [Nn]* )
        echo "... Initializing an empty git repo."
        cd "${V_WORKING_DIR}"
        git init;
        break;;
      * ) echo "Please answer y or n.";;
    esac
  done
  echo ""
fi


# Heroku
canDoAMachine=false
while true; do
  read -p "Do you want to login to Heroku? [y/n/a(lready)]" yn
  case $yn in
    [Yy]* )
      herokuconfig
      canDoAMachine=true
      break;;
    [aA]* )
      echo "Ok then... Next step"
      canDoAMachine=true
      break;;
    [Nn]* ) break;;
        * ) echo "Please answer y or n.";;
  esac
  echo ""
done

if [ ${canDoAMachine} == true ]; then
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
  echo ""
fi

echo ""
echo "All done."
