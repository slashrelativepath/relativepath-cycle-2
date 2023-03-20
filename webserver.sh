#!/bin/bash
# script to create an Ubuntu VM with nginx installed

echo "Checking operating system..."
if ( "$(uname)" == 'Linux' );
then

    echo "i'm on linux"
    if ( -x "command -v snap" );
    then
        echo "snap installed already"
    else
        echo "installing snapd..."
        sudo apt install snapd
    fi
    
    if ( -x "command -v multipass" );
    then
        echo "multipass already installed"
    else
        echo "installing multipass..."
        sudo snap install multipass
    fi
    
elif ( "$(uname)" == 'Darwin' );
then
    echo "i'm on Mac"
    echo "installing brew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "installing multipass..."
    brew install --cask multipass     
fi

echo "launching relativepath instance with multipass"
multipass launch --name relativepath

# Check for existing ssh keys
if [ -f "~/.ssh/relativepath-ed25519" ]; then
	echo "relativepath ssh key exists"
else
	echo "relativepath ssh key does not exist, creating..."
	ssh-keygen -f ~/.ssh/relativepath-ed25519 -t ed25519 -b 4096
fi 
# Add SSH public key to VM
# Add SSH command to login to VM

echo "show distro information using multipass exec"
multipass exec relativepath -- lsb_release -a

echo "update apt for all current package info"
multipass exec relativepath -- sudo apt update -yq

echo "installing nginx quietly..."
multipass exec relativepath -- sudo apt install -yq nginx

if [ multipass exec relativepath -- nginx -v ];
then
    multipass exec relativepath -- sudo systemctl start nginx
else
    echo "nginx installation failed: exiting"
    exit 1
fi

