#!/bin/zsh

echo -e "\n[ Mackit ] ~ Configuring VSCode keybindings."

if ! command -v jq &>/dev/null; then
    echo "The command line tool \'jq\' is required to run vscode-keybindings.sh."
    exit 1
fi

# make sure dependency exists
if ! command -v jq &>/dev/null; then
    echo "The command line tool \'jq\' is required to run vscode-keybindings.sh."
    exit 1
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
    exit 1
fi
if [ ! -w "$VSCODE_KEYBINDINGS" ]; then
    echo "VSCode's keybindings file could not be written to."
    exit 1
fi
if ! jq empty "$VSCODE_KEYBINDINGS" 2>/dev/null; then
    echo "VSCode's keybindings file's existing JSON is invalid, cannot append."
    exit 1
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
    exit 1
fi

# backup (this overwrites the previous overwrite) 
cp "$VSCODE_KEYBINDINGS" "$VSCODE_KEYBINDINGS.bak" || exit 1

# merge (ensure there are no duplicates)
jq --argjson new "$NEW_BINDINGS" '
    ($new + .) | unique_by([.key, .command, .when])
' "$VSCODE_KEYBINDINGS" > /tmp/keybindings_tmp.json \
  && mv /tmp/keybindings_tmp.json "$VSCODE_KEYBINDINGS"

if [ "$CHILD" != "true" ]; then
    echo -e "\n[ Mackit - VSCode Keybindings ]\n~ This script optimized your MacOS VSCode Keybindings for efficiency.\n~ If you found this useful, please leave a star on the project: https://github.com/jaidencoleflannery/mackit \n"
fi