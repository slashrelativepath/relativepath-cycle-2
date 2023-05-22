#!/bin/bash
if (pwd == $HOME);
then
    sudo apt update -yq
    
    if ! ( command -v nginx 2> /dev/null )
    then
        sudo apt install nginx -yq || exit
    fi
    
    sudo systemctl start nginx
    exit 0
else
    exit
fi
