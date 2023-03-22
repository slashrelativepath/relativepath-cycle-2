#!/bin/bash
# script to create an Ubuntu VM with nginx installed

echo "Checking operating system..."
if [ "$(uname)" == 'Linux' ]
then

    echo "i'm on linux"
    if ( command -v snap )
    then
        echo "snap installed already"
    else
        echo "installing snapd..."
        sudo apt install snapd
    fi
    
    if ( command -v multipass )
    then
        echo "multipass already installed"
    else
        echo "installing multipass..."
        sudo snap install multipass
    fi
    
elif [ "$(uname)" == 'Darwin' ]
then
    echo "i'm on Mac"
    echo "installing brew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "installing multipass..."
    brew install --cask multipass     
fi

# Check for existing ssh keys
if [ -f "./ed25519" ]
then
	echo "relativepath ssh key exists"
else
	echo "relativepath ssh key does not exist, creating..."
	ssh-keygen -f "./ed25519" -t ed25519 -b 4096 -N ''
fi

# if [ -f "./cloud-init.yaml" ]
# then
#     echo "cloud-init already exists"
# else

# fi

echo "launching relativepath instance with multipass"
if ( multipass info relativepath )
then
    echo "relativepath vm already exists!"
else
    echo "creating relative path vm..."
    multipass launch --name relativepath --cloud-init ./cloud-init.yaml
fi

# Add SSH public key to VM
# Add SSH command to login to VM

ssh ubuntu@$(multipass info relativepath | grep IPv4 | awk '{ print $2 }')