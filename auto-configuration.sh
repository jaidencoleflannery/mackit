#!/bin/zsh

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/modules/vscode-keybindings.sh" true
source "$SCRIPT_DIR/modules/vscode-settings.sh" true
source "$SCRIPT_DIR/modules/preferences.sh" true
source "$SCRIPT_DIR/modules/packages.sh" true

echo -e "\n[ Mackit ]\n~ This script optimized your MacOS configuration for efficiency.\n~ If you found this useful, please leave a star on the project: https://github.com/jaidencoleflannery/mackit \n"