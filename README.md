# mackit
Optimize the macOS operating system for software development efficiency.

## Quick Start

> **Warning:** Running the following commands executes all scripts in this repository. Please review the changes this project makes before running on your system.\
> **Note:** the quick start script expects you to have VSCode installed. VSCode specific scripts will fail if you do not.

**Option 1 - Run directly:**
```zsh
curl -s https://raw.githubusercontent.com/jaidencoleflannery/mackit/master/auto-configuration.sh | zsh
```

**Option 2 - Clone and run locally:**
```zsh
git clone https://github.com/jaidencoleflannery/mackit.git && cd mackit && chmod +x auto-configuration.sh && ./auto-configuration.sh
```

---

## Modules

> **Note:** This project is a compilation of scripts, referred to as "modules" -
> following sections focus on what changes each module makes.

### VSCode Settings
**vscode-settings.sh:**
- **editor.tabCompletion**: `"off"` - Tab key does not cycle through autocomplete suggestions.
- **editor.formatOnType**: `false` - Code is not automatically formatted as you type.
- **editor.formatOnPaste**: `false` - Pasted code is not automatically formatted.
- **editor.formatOnSave**: `false` - File is not automatically formatted on save.
- **editor.hover.enabled**: `"on"` - Hovering over symbols shows tooltips.
- **security.workspace.trust.untrustedFiles**: `"open"` - Files in untrusted workspaces are opened without prompting.
- **keyboard.dispatch**: `"keyCode"` - Key events are dispatched by key code rather than character, for compatibility with unorthodox layouts.
- **git.confirmSync**: `false` - Git push/pull sync runs without a confirmation dialog.
- **workbench.startupEditor**: `"none"` - No popup is opened on startup.
- **git.ignoreRebaseWarning**: `true` - No warning shown when a rebase is in progress.
- **workbench.activityBar.location**: `"top"` - The activity bar is placed at the top of the sidebar instead of the side.
- **files.exclude** `**/.git: false` - Overrides the default which hides `.git` folders, so they're visible in the Explorer.
- **editor.acceptSuggestionOnEnter**: `"off"` - Enter key does not accept an autocomplete suggestion.
- **git.openRepositoryInParentFolders**: `"never"` - VS Code never detects and opens Git repos found in parent directories.
- **editor.codeActionsOnSave** `source.fixAll: "never"` - All auto fix code actions are disabled on save.
- **editor.codeActionsOnSave** `source.fixAll.eslint: "never"` - ESLint auto fix disabled on save.
- **explorer.confirmDragAndDrop**: `false` - Drag and drop in the Explorer happen without a prompt.

### VSCode Keybindings
**vscode-keybindings.sh:**
| Shortcut | Action |
|----------|--------|
| `cmd+t` | New file |
| `cmd+shift+t` | New folder |
| `cmd+w` | Close |
| `cmd+[` | Cycle left |
| `cmd+]` | Cycle right |
| `cmd+b` | Toggle file explorer |
| `` cmd+` `` | Toggle terminal |
- **tab** `-acceptSelectedSuggestion` - Removes Tab as the key to accept an autocomplete suggestion.
- **tab** `-editor.action.inlineSuggest.commit` - Removes Tab as the key to accept an inline suggestion.
- **cmd+t** `-workbench.action.showAllSymbols` - Unbinds the default <Go to Symbol> command for cmd+t.
- **cmd+t** `workbench.action.terminal.split` - Splits the current terminal pane.
- **cmd+t** `explorer.newFile` `when: explorerViewletFocus` - Creates a new file when the Explorer sidebar is focused.
- **cmd+w** `workbench.action.terminal.kill` `when: terminalFocus` - Closes/kills the active terminal when a terminal is focused.
- **cmd+[** `workbench.action.terminal.focusPreviousPane` `when: terminalFocus` - Focuses the previous terminal pane when in the terminal.
- **cmd+]** `workbench.action.terminal.focusNextPane` `when: terminalFocus` - Focuses the next terminal pane when in the terminal.
- **cmd+[** `workbench.action.previousEditor` `when: editorFocus` - Navigates to the previous editor tab when in the editor.
- **cmd+]** `workbench.action.nextEditor` `when: editorFocus` - Navigates to the next editor tab when in the editor.
- **cmd+b** `workbench.explorer.fileView.focus` `when: activeViewlet != explorer` - Opens and focuses the Explorer sidebar when it isn't already active.
- **cmd+b** `workbench.action.focusActiveEditorGroup` `when: explorer is active OR no editorFocus` - Returns focus to the active editor when the Explorer is open or no editor is focused; effectively toggles focus back.
- **cmd+shift+t** `explorer.newFolder` `when: explorerViewletFocus` - Creates a new folder when the Explorer sidebar is focused.