#!/bin/bash
if (pwd == $HOME);
then
    sudo apt update -yq && sudo apt upgrade -yq
    
    if ! ( command -v nginx 2> /dev/null )
    then
        sudo apt install nginx -yq || exit
    fi
    
    sudo systemctl start nginx
    if ( command systemctl status nginx | grep master )
    then
        exit 0
    else
        exit
    fi
else
    exit
fi
