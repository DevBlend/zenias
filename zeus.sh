#!/usr/bin/env bash

export zeusargv1=$1
export zeusargv2=$2

gitconfig () {
    read -p "What is your real name? >>> " username
    read -p "What is your Github email address? >>> " email
    read -p "what is your Github username? >>> " githubusername
    git config --global user.email "$email"
    git config --global user.name "$username"
    git config --global push.default simple
    echo "githubusername: $githubusername" >> /home/vagrant/.configs/github_config
}

gitcreate () {
    read -p "How should the Github remote repo be called? >>> " remoterepo
    githubname=$(cat ~/.configs/github_config | egrep "githubusername" | tail -1 | awk '{print $2}')
    case $zeusargv2 in
        private)
            curl -u "$githubname" https://api.github.com/user/repos -d '{"name":'"\"$remoterepo\""',"private":"true"}'
            ;;
        public)
            curl -u "$githubname" https://api.github.com/user/repos -d '{"name":'"\"$remoterepo\""'}'
            ;;
    esac
}

case $zeusargv1 in
    gitconfig)
        gitconfig
        ;;
    gitcreate)
        gitcreate
        ;;
    *)
        echo "Invalid argument parsed"
        ;;
esac
