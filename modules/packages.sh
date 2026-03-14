#!/bin/zsh

echo -e "\n[ Mackit ] ~ Installing core packages."

# if ran from a parent, do not print
CHILD=$1

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install git
brew install node
brew install python
brew install gcc
brew install make
brew install docker
brew install docker-compose
brew install colima # required for mac to be able to run linux vm
brew install postgresql
brew install redis
brew install sqlite
brew install curl
brew install jq # required for later scripts
brew install dotnet

if [ "$CHILD" != true ]; then
    echo -e "\n[ Mackit - Packages ]\n~ This script installed commonly used packages on your system.\n~ If you found this useful, please leave a star on the project: https://github.com/jaidencoleflannery/mackit \n"
fi