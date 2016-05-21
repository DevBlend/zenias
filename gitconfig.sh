#!/bin/sh

gitConfig () {
    git config --global user.email "$email"
    git config --global user.name "$username"
    git config --global push.default simple
}

if [ ! -f ~/.gitconfig ]
then
    read -p "What is your real name? " username
    read -p "What is your Github email address? " email
    gitConfig
fi
