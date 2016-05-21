#!/usr/bin/env bash

iterator1=0
iterator2=0

while [[ $iterator1 = 0 && $iterator2 -lt 5 && ! -f /users/john/desktop/file.txt ]]
do
    read -p 'Do you wish to setup Github credentials for easy access? y/n' github

    if [ $github = 'y' ]
    then
        echo Done
        touch /users/john/desktop/file.txt
        iterator1=1
    elif [ $github = 'n' ]
    then
        echo 'You can setup Github credentials later by using the command gitconfig'
        iterator1=1
    else
        echo 'Your answer is not recognised, please enter either y or n'
        ((iterator2++))
    fi
done

if [ $iterator2 = 5 ]
then
    echo 'You can setup Github credentials later by using the command gitconfig'
fi
