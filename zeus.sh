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
# Logo
z_logo() {
  cat << EOF


\e[31m         (    (
\e[31m   (    ))\  ))\  (    \e[39mZeus: Vagrant boxes with Heroku integration
\e[31m   )\  /(\e[33m(_)\e[31m/(\e[33m(_) )\\
\e[31m  (\e[33m(_)(_)\e[31m) \e[33m(_)\e[31m)( (\e[33m(_)    \e[32mA FreeCodeCamp project (http://freecodecamp.com)
\e[32m  |_ // -_)| || |(_-<
\e[32m  /__|\___| \_,_|/__/  \e[39mv ${Z_VERSION}
  ${Z_STATE} script


EOF
}

# Help
z_help() {
  cat << EOF
Usage: zeus -l <language> -d <destination> [-o <options> -g -h -n -c]

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

z_export() {
  cat << EOF
#!/bin/bash -
export Z_LANGUAGE="${Z_LANGUAGE}"
export Z_DESTINATION="${Z_DESTINATION}"
export Z_OPTION="${Z_OPTION}"
export Z_GITHUB_CRED=${Z_GITHUB_CRED}
export Z_HEROKU_CRED=${Z_HEROKU_CRED}
export Z_GITHUB_NEWREPO=${Z_GITHUB_NEWREPO}
export Z_HEROKU_NEWMACHINE=${Z_HEROKU_NEWMACHINE}

cd /vagrant/vagrant
./provision.sh
EOF
}

export -f z_logo
export -f z_help
export -f z_export
export -f z_error


if [ "$@" == "-z" ]; then # We have been called by Vagrantfile
  export Z_STATE='Guest'
  #/vagrant/vagrant/./zeus_config.sh "$@"
else # Normal call
  export Z_STATE='Host'
  ./zeus_host_script.sh "$@"
fi
