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

if ( grep "$(cat ./ed25519.pub)" ./cloud-init.yaml 2> /dev/null )  # [ -f ./cloud-init.yaml ] #
then
    echo "cloud-init.yaml already exists and is correct"
else
    echo "create cloud-init.yaml and add the ssh public key..."
    cat <<- EOF > cloud-init.yaml
users:
  - default
  - name: rp-user
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - $(cat ./ed25519.pub)
EOF
fi

echo "launching relativepath instance with multipass"
if ( multipass info relativepath 2> /dev/null )
then
    echo "relativepath vm already exists!"
else
    echo "creating relative path vm..."
    multipass launch --name relativepath --cloud-init cloud-init.yaml
fi

echo 'Copying vm-install script to vm $HOME...'
scp -i ./ed25519 -o StrictHostKeyChecking=accept-new -q ./vm-install.sh rp-user@$(multipass info relativepath | grep IPv4 | awk '{ print $2 }'):/home/rp-user/vm-install.sh || exit

echo 'Executing vm-install script...'
ssh -i ./ed25519 rp-user@$(multipass info relativepath | grep IPv4 | awk '{ print $2 }') "bash ~/vm-install.sh" || exit

echo "Opening terminal on vm..."
ssh -i ./ed25519 rp-user@$(multipass info relativepath | grep IPv4 | awk '{ print $2 }') || exit

echo "Destroying webserver vm configuration..."
bash destroy_webserver.sh

exit