#!/usr/bin/env bash

# Making the arguments of the dblend command available to the whole script
export dblendargv1=$1
export dblendargv2=$2

gitconfig () {
    # Ask user for input to set up GitHub and git configs.
    read -p "What is your real name? >>> " username
    read -p "What is your Github email address? >>> " email
    read -p "what is your Github username? >>> " githubusername
    git config --global user.email "$email"
    git config --global user.name "$username"
    # Set push to simple
    git config --global push.default simple
    # Store the GitHub username inside github_config so that gitcreate
    # can retrieve the username to perform Github API call
    echo "githubusername: $githubusername" >> /home/vagrant/.configs/github_config
}

gitcreate () {
    # Create a private or public repo on Github
    read -p "How should the Github remote repo be called? >>> " remoterepo
    # Get the stored GitHub username inside github_config
    githubname=$(cat ~/.configs/github_config | egrep "githubusername" | tail -1 | awk '{print $2}')
    # Loop to create the remote repo
    case $dblendargv2 in
        private)
            curl -u "$githubname" https://api.github.com/user/repos -d '{"name":'"\"$remoterepo\""',"private":"true"}'
            ;;
        public)
            curl -u "$githubname" https://api.github.com/user/repos -d '{"name":'"\"$remoterepo\""'}'
            ;;
    esac
}

# Choice of which function to use based on user input of dblend' arguments
case $dblendargv1 in
    gitconfig)
        gitconfig
        ;;
    gitcreate)
        gitcreate
        ;;
    help)
        echo "Zeus - the tool to make web development faster"
        echo "You have the following commands: dblend gitconfig, dblend gitcreate private, dblend gitcreate public."
        echo "You need to run dblend gitconfig first in order to use the rest"
        echo "dblend gitconfig creates or overwrites existing git username, email, and push configurations."
        echo "dblend gitcreate creates a public or private GitHub repo depending on the second argument you give."
        ;;
    *)
        echo "Invalid argument parsed"
        ;;
esac
