#!/usr/bin/env bash

gitConfig () {
    read -p "What is your real name? >>> " username
    read -p "What is your Github email address? >>> " email
    read -p "what is your Github username? >>> " githubusername
    git config --global user.email "$email"
    git config --global user.name "$username"
    git config --global push.default simple
    export githubname=$githubusername
}

gitCreate () {
    read -p "How should the Github remote repo be called? >>> " remoterepo
    case $2 in
        private)
            curl -u "$githubname" https://api.github.com/user/repos -d '{"name":'"\"$remoterepo\""',"private":"true"}'
            ;;
        public)
            curl -u "$githubname" https://api.github.com/user/repos -d '{"name":'"\"$remoterepo\""'}'
            ;;
        *)
            echo "Invalid argument parsed"
            ;;
    esac
}

case $1 in
    gitConfig)
        gitConfig
        ;;
    gitCreate)
        gitCreate
        ;;
    *)
        echo "Invalid argument parsed"
        ;;
esac
