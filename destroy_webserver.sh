#!/bin/bash

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