#!/bin/zsh

echo -e "Configuring VSCode keybindings."

# flag for if script is a subscript
CHILD=$1;

VSCODE_KEYBINDINGS="$HOME/Library/Application Support/Code/User/keybindings.json"

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
if [[ ! -f "$VSCODE_KEYBINDINGS" ]] || [[ ! -s "$VSCODE_KEYBINDINGS" ]]
    then {
        mkdir -p "$(dirname "$VSCODE_KEYBINDINGS")";
        echo "{}" > "$VSCODE_KEYBINDINGS";
    }
fi

# accessible and not empty?
if [[ ! -r "$VSCODE_KEYBINDINGS" ]]
    then {
        echo "VSCode's keybindings file could not be found or accessed." >&2;
        if [[ $CHILD == true ]]; 
            then {
                return 1;
            }
        fi
        exit 1;
    }
fi
if [[ ! -w "$VSCODE_KEYBINDINGS" ]]
    then {
        echo "VSCode's keybindings file could not be written to.";
        if [[ $CHILD == true ]]
            then {
                return 1;
            }
        fi
        exit 1;
    }
fi
if ! jq empty "$VSCODE_KEYBINDINGS" 2>/dev/null
    then {
        echo "VSCode's keybindings file's existing JSON is invalid, cannot append.";
        if [[ $CHILD == true ]] 
            then {
                return 1;
            }
        fi
        exit 1;
    }
fi

NEW_KEYBINDINGS='[
    { "key": "tab",         "command": "-acceptSelectedSuggestion" },
    { "key": "tab",         "command": "-editor.action.inlineSuggest.commit" },
    { "key": "cmd+t",       "command": "-workbench.action.showAllSymbols" },
    { "key": "cmd+t",       "command": "workbench.action.terminal.split" },
    { "key": "cmd+t",       "command": "explorer.newFile",                              "when": "explorerViewletFocus" },
    { "key": "cmd+w",       "command": "workbench.action.terminal.kill",                "when": "terminalFocus" },
    { "key": "cmd+[",       "command": "workbench.action.terminal.focusPreviousPane",   "when": "terminalFocus" },
    { "key": "cmd+]",       "command": "workbench.action.terminal.focusNextPane",       "when": "terminalFocus" },
    { "key": "cmd+[",       "command": "workbench.action.previousEditor",               "when": "editorFocus" },
    { "key": "cmd+]",       "command": "workbench.action.nextEditor",                   "when": "editorFocus" },
    { "key": "cmd+b",       "command": "workbench.explorer.fileView.focus",             "when": "activeViewlet != workbench.view.explorer" },
    { "key": "cmd+b",       "command": "workbench.action.focusActiveEditorGroup",       "when": "activeViewlet == workbench.view.explorer || !editorFocus" },
    { "key": "cmd+shift+t", "command": "explorer.newFolder",                            "when": "explorerViewletFocus" }
]'

# check if JSONC is being used
if grep -qE '^\s*//|/\*|\*/' "$VSCODE_KEYBINDINGS"; then
    echo "JSONC detected, keybindings could not be written.";
    if [[ $CHILD == true ]]
        then {
            return 1;
        }
    fi
    exit 1;
fi

# backup (this overwrites on each run)
cp "$VSCODE_KEYBINDINGS" "$VSCODE_KEYBINDINGS.bak" || {
    echo -e "Failed to create keybindings backup.";
    if [[ $CHILD == true ]]
        then {
            return 1;
        }
    fi
    exit 1;
}

# if file is an empty object, it should be an empty array
EXISTING=$(jq 'if type == "object" then [] else . end' "$VSCODE_KEYBINDINGS")

# our json block has to be stored so it can be propery read
echo "$NEW_KEYBINDINGS" > /tmp/new_keybindings.json

# merge (ensure there are no duplicates)
if ! echo "$EXISTING" | jq --slurpfile new /tmp/new_keybindings.json \
    '. + $new[0] | unique_by(.key + (.command // ""))' \
    > /tmp/keybindings_tmp.json 2>/tmp/keybindings_jq_err.json; then
        echo "\'jq\' failed to merge keybindings. Details:"
        cat /tmp/keybindings_jq_err.json
    if [[ $CHILD == true ]]
            then { 
                return 1;
            }
    fi
    exit 1; 
fi

if ! mv /tmp/keybindings_tmp.json "$VSCODE_KEYBINDINGS"
    then {
        echo "Failed to perform replacement of keybindings.";
        if [[ $CHILD == true ]]
            then {
                return 1;
            }
        fi
        exit 1;
    } else {
        echo "Successfully wrote to VSCode's keybindings.json.";
    }
fi

if [[ $CHILD == false ]]; then
    echo -e "\n[ Mackit - VSCode Keybindings ]\n~ This script optimized your MacOS VSCode Keybindings for efficiency.\n~ If you found this useful, please leave a star on the project: https://github.com/jaidencoleflannery/mackit \n"
fi