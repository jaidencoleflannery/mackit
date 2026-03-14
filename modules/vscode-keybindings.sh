#!/bin/zsh

echo -e "\n[ Mackit ] ~ Configuring VSCode keybindings."

# make sure dependency exists
if ! command -v jq &>/dev/null; then
    echo -e "The command line tool \'jq\' is required to run vscode-keybindings.sh."
    return 1
fi

# if ran from a parent, do not print
CHILD=$1

# path to keybindings
VSCODE_KEYBINDINGS="$HOME/Library/Application Support/Code/User/keybindings.json"

# create file if it doesnt exist, or write if empty
if [ ! -f "$VSCODE_KEYBINDINGS" ] || [ ! -s "$VSCODE_KEYBINDINGS" ]; then
    mkdir -p "$(dirname "$VSCODE_KEYBINDINGS")"
    echo "{}" > "$VSCODE_KEYBINDINGS"
fi

# accessible and not empty?
if [ ! -r "$VSCODE_KEYBINDINGS" ]; then
    echo "VSCode's keybindings file could not be found or accessed."
    return 1
fi
if [ ! -w "$VSCODE_KEYBINDINGS" ]; then
    echo "VSCode's keybindings file could not be written to."
    return 1
fi
if ! jq empty "$VSCODE_KEYBINDINGS" 2>/dev/null; then
    echo "VSCode's keybindings file's existing JSON is invalid, cannot append."
    return 1
fi

NEW_BINDINGS='[
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
if grep -qE '^\s*//|^\s*/\*' "$VSCODE_KEYBINDINGS"; then
    echo "JSONC detected, keybindings could not be written."
    return 1
fi

# backup (this overwrites the previous overwrite) 
cp "$VSCODE_KEYBINDINGS" "$VSCODE_KEYBINDINGS.bak" || {
    echo -e "Failed to create keybindings backup."; 
    return 1; 
}

# if file is an empty object, it should be an empty array
EXISTING=$(jq 'if type == "object" then [] else . end' "$VSCODE_KEYBINDINGS")

# merge (ensure there are no duplicates)
if ! echo "$EXISTING" | jq --argjson new "$NEW_KEYBINDINGS" \
    '. * $new | unique_by(.key + .command)' \
    > /tmp/keybindings_tmp.json 2>/tmp/keybindings_jq_err.json; then
        echo "\'jq\' failed to merge keybindings. Details:"
        cat /tmp/keybindings_jq_err.json
    return 1
fi

mv /tmp/keybindings_tmp.json "$VSCODE_KEYBINDINGS"

if [ "$CHILD" != "true" ]; then
    echo -e "\n[ Mackit - VSCode Keybindings ]\n~ This script optimized your MacOS VSCode Keybindings for efficiency.\n~ If you found this useful, please leave a star on the project: https://github.com/jaidencoleflannery/mackit \n"
fi