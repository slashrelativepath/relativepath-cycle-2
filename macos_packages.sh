#!/bin/bash
# script to create an Ubuntu VM with nginx installed

echo "installing brew"
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "installing multipass"
brew install --cask multipass