#!/usr/bin/env bash

gitConfig () {
    read -p "What is your real name? " username
    read -p "What is your Github email address? " email
    git config --global user.email "$email"
    git config --global user.name "$username"
    git config --global push.default simple
}

case $1 in
    gitConfig)
        gitConfig
        ;;
    *)
        echo "Invalid argument parsed"
        ;;
esac
