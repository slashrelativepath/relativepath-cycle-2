#!/bin/bash
# script to create an Ubuntu VM with nginx installed

if [ "$(uname)" == 'Linux' ]
then
    echo "i'm on linux"
    if [ -x ! "command -v snapd" ]; then
        sudo apt install snapd
    fi
    sudo snap install multipass
elif [ "$(uname)" == 'Darwin' ]
then
     echo "i'm on Mac"

     echo "installing brew"
     NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

     echo "installing multipass"
     brew install --cask multipass
     
fi

echo "launching relativepath instance with multipass"
multipass launch --name relativepath

echo "show distro information using multipass exec"
multipass exec relativepath -- lsb_release -a

