#!/bin/bash

if ( multipass info relativepath 2> /dev/null )
then
    echo "Deleting the vm relativepath..."
    multipass delete --purge relativepath
else
    echo "the vm relative has already been deleted!"
fi
