#!/bin/zsh

echo -e "[ NEOVIM-SETTINGS ] Configuring NVIM settings."

# flag for if script is a subscript.
CHILD=$1

NVIM_SETTINGS_DIRECTORY="$HOME/.config/nvim"

if ! command -v jq &>/dev/null
    then {
        echo -e "[ NEOVIM-SETTINGS ] Error - The command line tool 'jq' is required to run neovim-settings.sh.";
        # if child process, just error.
        if [[ $CHILD == true ]]
            then {
                return 1;
            }
        fi
        # if main process, fullstop.
        exit 1;
    }
fi

# create file if it doesn't exist.
if [[ ! -f "$NVIM_SETTINGS_DIRECTORY" ]] || [[ ! -s "$NVIM_SETTINGS_DIRECTORY" ]]
    then {
        mkdir -p "$(dirname "NVIM_SETTINGS_DIRECTORY")";
        echo "" > "$NVIM_SETTINGS_DIRECTORY";
    }
fi


