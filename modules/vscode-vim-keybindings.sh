#!/bin/zsh

echo -e "Configuring VSCode Vim keybindings.";

# flag for if script is a subscript
CHILD=$1;

VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json";

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
    "vim.useSystemClipboard": true,
    "vim.visualModeKeyBindingsNonRecursive": [ 
        {
            "before": ["g", "d"],
            "commands": ["editor.action.revealDefinition"]
        }
    ],
    "vim.leader": "<space>",
    "vim.normalModeKeyBindingsNonRecursive": [ 
        {
            "before": ["<leader>", "d", "s"],
            "commands": ["workbench.action.debug.selectandstart", "extension.vim_escape"]
        },
        {
            "before": ["<leader>", "d", "c"],
            "commands": ["workbench.action.debug.continue", "extension.vim_escape"]
        },
        {
            "before": ["c"],
            "commands": ["extension.vim_escape"],
            "when": "inDebugMode"
        },
        {
            "before": ["c", "c"],
            "commands": ["extension.vim_escape"],
            "when": "inDebugMode"
        },
        {
            "before": ["C"],
            "commands": ["extension.vim_escape"],
            "when": "inDebugMode"
        },
        {
            "before": ["<leader>", "d", "x"],
            "commands": ["workbench.action.debug.stop", "extension.vim_escape"]
        },
        {
            "before": ["<leader>", "d", "r"],
            "commands": ["workbench.action.debug.restart", "extension.vim_escape"]
        },
        {
            "before": ["<leader>", "d", "b"],
            "commands": ["editor.debug.action.toggleBreakpoint", "extension.vim_escape"]
        },         
        {
            "before": ["g", "e"],
            "commands": ["editor.action.showHover"]
        },
        {
            "before": ["g", "d"],
            "commands": ["editor.action.revealDefinition", "extension.vim_escape"]
        } 
    ],
    "extensions.experimental.affinity": {
        "vscodevim.vim": 1
    }
}';

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

if [[ $CHILD == false ]]; then
    echo -e "\n[ Mackit - VSCode Vim Settings ]\n~ This script optimized your MacOS VSCode Vim Settings for efficiency.\n~ If you found this useful, please leave a star on the project: https://github.com/jaidencoleflannery/mackit \n"
fi