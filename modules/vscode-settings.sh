#!/bin/zsh

echo -e "Configuring VSCode settings."

# flag for if script is subscript
CHILD=$1

VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"

if ! command -v jq &>/dev/null 
    then {
        echo -e "The command line tool 'jq' is required to run vscode-vim-keybindings.sh";
        if [[ $CHILD == true ]]
            then {
                return 1;
            }
        fi
        exit 1;
    }
fi

# create file if it doesnt exist, or write if empty
if [[ ! -f "$VSCODE_SETTINGS" ]] || [[ ! -s "$VSCODE_SETTINGS" ]]
    then {
        mkdir -p "$(dirname "$VSCODE_SETTINGS")";
        echo "{}" > "$VSCODE_SETTINGS";
    }
fi

# accessible and not empty?
if [[ ! -r "$VSCODE_SETTINGS" ]]
    then {
        echo "VSCode's settings file could not be found or accessed." >&2;
        if [[ $CHILD == true ]]; 
            then {
                return 1;
            }
        fi
        exit 1;
    }
fi
if [[ ! -w "$VSCODE_SETTINGS" ]]
    then {
        echo "VSCode's settings file could not be written to.";
        if [[ $CHILD == true ]]
            then {
                return 1;
            }
        fi
        exit 1;
    }
fi
if ! jq empty "$VSCODE_SETTINGS" 2>/dev/null
    then {
        echo "VSCode's settings file's existing JSON is invalid, cannot append.";
        if [[ $CHILD == true ]] 
            then {
                return 1;
            }
        fi
        exit 1;
    }
fi

NEW_SETTINGS='{
    "editor.wordBasedSuggestions": "off",
    "editor.suggestOnTriggerCharacters": false,
    "editor.acceptSuggestionOnCommitCharacter": false,
    "editor.quickSuggestions": {
        "other": "off",
        "comments": "off",
        "strings": "off"
    },
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
if grep -qE '^\s*//|/\*|\*/' "$VSCODE_SETTINGS"; then
    echo "JSONC detected, settings could not be written.";
    if [[ $CHILD == true ]]
        then {
            return 1;
        }
    fi
    exit 1;
fi

# backup (this overwrites on each run)
cp "$VSCODE_SETTINGS" "$VSCODE_SETTINGS.bak" || {
    echo -e "Failed to create settings backup.";
    if [[ $CHILD == true ]]
        then {
            return 1;
        }
    fi
    exit 1;
}

# merge (ensure there are no duplicates)
if ! jq --argjson new "$NEW_SETTINGS" '. * $new' "$VSCODE_SETTINGS" > /tmp/settings_tmp.json 2> /tmp/settings_jq_err.json; 
    then {
        echo "\'jq\' failed to merge settings. Details:";
        cat /tmp/settings_jq_err.json;
        if [[ $CHILD == true ]]
            then { 
                return 1;
            }
        fi
        exit 1;
    }
fi

if ! mv /tmp/settings_tmp.json "$VSCODE_SETTINGS"
    then {
        echo "Failed to perform replacement of settings.";
        if [[ $CHILD == true ]]
            then {
                return 1;
            }
        fi
        exit 1;
    } else {
        echo "Successfully wrote to VSCode's settings.json.";
    }
fi