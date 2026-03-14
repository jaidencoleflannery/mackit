#!/bin/zsh

echo -e "\n[ Mackit ] ~ Initializing."

BASE_URL="https://raw.githubusercontent.com/jaidencoleflannery/mackit/master/modules"

source <(curl -s "$BASE_URL/vscode-keybindings.sh") true
source <(curl -s "$BASE_URL/vscode-settings.sh") true
source <(curl -s "$BASE_URL/preferences.sh") true
source <(curl -s "$BASE_URL/packages.sh") true

echo -e "\n[ Mackit ]\n~ This script optimized your MacOS configuration for efficiency.\n~ If you found this useful, please leave a star on the project: https://github.com/jaidencoleflannery/mackit \n"