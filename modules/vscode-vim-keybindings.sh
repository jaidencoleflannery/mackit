#!/bin/zsh

echo -e "[[ Mackit ]] ~ Configuring VSCode Vim keybindings."

if ! command -v jq &>/dev/null; then
    echo "The command line tool \'jq\' is required to run vscode-vim-keybindings.sh"
    return 1
fi

# if ran from parent, do not print tagline
CHILD=$1

VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"

# create file if it doesnt exist, or write if empty
if [[ ! -f "$VSCODE_SETTINGS" ]] || [[ ! -s "$VSCODE_SETTINGS" ]]; then
    mkdir -p "$(dirname "$VSCODE_SETTINGS")"
    echo "{}" > "$VSCODE_SETTINGS"
fi

# accessible and not empty?
if [[ ! -r "$VSCODE_SETTINGS" ]]; then
    echo "VSCode's settings file could not be found or accessed." >&2
    if [[ $CHILD == false ]]; then
        exit 1
    fi
    return 1
fi
if [[ ! -w "$VSCODE_SETTINGS" ]]; then
    echo "VSCode's settings file could not be written to"
    if [[ $CHILD == false ]]; then
        exit 1
    fi
    return 1
fi
if ! jq empty "$VSCODE_SETTINGS" 2>/dev/null; then
    echo "VSCode's settings file's existing JSON is invalid, cannot append."
    if [[ $CHILD == false ]]; then
        exit 1
    fi
    return 1
fi

