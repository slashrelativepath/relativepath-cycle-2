#!/bin/bash

if ( ip=ssh-keygen -H -F $(multipass info crownapp |  grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | awk '{print $2}') ) 
then
    echo -e "\n==== Deleting fingerprint from known host ====\n"
    ssh-keygen -f ~/.ssh/known_hosts -R $ip
    else 
    echo -e "\n==== Fingerprint not present in known host ====\n"
fi 

if ( multipass info relativepath 2> /dev/null )
then
    echo "Deleting the vm relativepath..."
    multipass delete --purge relativepath
else
    echo "the vm relative has already been deleted!"
fi

if [ -f ./ed25519 ] && [ -f ./ed25519.pub ]
then
    echo "Deleting the ed25519 file..."
    rm -f ./ed25519*
else
    echo "the ed25519 file has already been deleted!"
fi

if [ -f ./cloud-init.yaml ]
then
    echo "Deleting the cloud-init file..."
    rm -f ./cloud-init.yaml
else
    echo "the cloud-init file has already been deleted!"
fi

if ( command -v multipass )
then 
    echo "Removing multipass..."
    sudo snap stop multipass
    sudo snap remove multipass -yq
else
    echo "Multipass does not exist."
fi

if ( command snap list | wc -l > 4 )
then
    echo "Multiple snaps are in use, snapd won't be removed"
else
    echo "Removing snapd..."
    sudo apt remove snapd
fi