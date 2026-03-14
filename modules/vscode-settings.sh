#!/bin/zsh

echo -e "\n[ Mackit ] ~ Configuring VSCode settings."

if ! command -v jq &>/dev/null; then
    echo "The command line tool \'jq\' is required to run vscode-settings.sh."
    return 1
fi

# if ran from parent, do not print
CHILD=$1

VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"

# create file if it doesnt exist, or write if empty
if [ ! -f "$VSCODE_SETTINGS" ] || [ ! -s "$VSCODE_SETTINGS" ]; then
    mkdir -p "$(dirname "$VSCODE_SETTINGS")"
    echo "{}" > "$VSCODE_SETTINGS"
fi

# accessible and not empty?
if [ ! -r "$VSCODE_SETTINGS" ]; then
    echo "VSCode's settings file could not be found or accessed."
    return 1
fi
if [ ! -w "$VSCODE_SETTINGS" ]; then
    echo "VSCode's settings file could not be written to."
    return 1
fi
if ! jq empty "$VSCODE_SETTINGS" 2>/dev/null; then
    echo "VSCode's settings file's existing JSON is invalid, cannot append."
    return 1
fi

NEW_SETTINGS='{
    "editor.tabCompletion": "off",
    "editor.formatOnType": false,
    "editor.formatOnPaste": false,
    "editor.formatOnSave": false,
    "editor.hover.enabled": "on",
    "security.workspace.trust.untrustedFiles": "open",
    "keyboard.dispatch": "keyCode",
    "git.confirmSync": false, 
    "workbench.startupEditor": "none", 
    "git.ignoreRebaseWarning": true, 
    "workbench.activityBar.location": "top",
    "files.exclude": {
        "**/.git": false
    },
    "editor.acceptSuggestionOnEnter": "off",
    "git.openRepositoryInParentFolders": "never",
    "editor.codeActionsOnSave": {
        "source.fixAll": "never",
        "source.fixAll.eslint": "never"
    },
    "explorer.confirmDragAndDrop": false
}'

# check if JSONC is being used
if grep -qE '^\s*//|^\s*/\*' "$VSCODE_SETTINGS"; then
    echo "JSONC detected, settings could not be written."
    return 1
fi

# backup (this overwrites on each run)
cp "$VSCODE_SETTINGS" "$VSCODE_SETTINGS.bak" || { 
    echo -e "Failed to create settings backup."; 
    return 1; 
}

# merge (ensure there are no duplicates)
if ! jq --argjson new "$NEW_SETTINGS" '. * $new' "$VSCODE_SETTINGS" > /tmp/settings_tmp.json 2>/tmp/settings_jq_err.json; then
  echo "\'jq\' failed to merge settings. Details:"
  cat /tmp/settings_jq_err.json
  return 1
fi
  
if ! mv /tmp/settings_tmp.json "$VSCODE_SETTINGS"; then
    echo "Failed to merge settings to \'$VSCODE_SETTINGS'."
    return 1
fi

echo "Settings written successfully to $VSCODE_SETTINGS"

if [ "$CHILD" != "true" ]; then
    echo -e "\n[ Mackit - VSCode Settings ]\n~ This script optimized your MacOS VSCode Settings for efficiency.\n~ If you found this useful, please leave a star on the project: https://github.com/jaidencoleflannery/mackit \n"
fi