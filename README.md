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
- **editor.tabCompletion**: `"off"` - tab key does not cycle through autocomplete suggestions.
- **editor.formatOnType**: `false` - code is not automatically formatted as you type.
- **editor.formatOnPaste**: `false` - pasted code is not automatically formatted.
- **editor.formatOnSave**: `false` - file is not automatically formatted on save.
- **editor.hover.enabled**: `"on"` - hovering over symbols shows tooltips.
- **security.workspace.trust.untrustedFiles**: `"open"` - files in untrusted workspaces are opened without prompting.
- **keyboard.dispatch**: `"keyCode"` - key events are dispatched by key code rather than character, for compatibility with unorthodox layouts.
- **git.confirmSync**: `false` - git push/pull sync runs without a confirmation dialog.
- **workbench.startupEditor**: `"none"` - no popup is opened on startup.
- **git.ignoreRebaseWarning**: `true` - no warning shown when a rebase is in progress.
- **workbench.activityBar.location**: `"top"` - the activity bar is placed at the top of the sidebar instead of the side.
- **files.exclude** `**/.git: false` - overrides the default which hides `.git` folders, so they're visible in the Explorer.
- **editor.acceptSuggestionOnEnter**: `"off"` - enter key does not accept an autocomplete suggestion.
- **git.openRepositoryInParentFolders**: `"never"` - vscode never detects and opens git repos found in parent directories.
- **editor.codeActionsOnSave** `source.fixAll: "never"` - all auto fix code actions are disabled on save.
- **editor.codeActionsOnSave** `source.fixAll.eslint: "never"` - eslint auto fix disabled on save.
- **explorer.confirmDragAndDrop**: `false` - drag and drop in the Explorer happen without a prompt.

### VSCode Keybindings
**vscode-keybindings.sh:**
| Shortcut | Action |
|----------|--------|
| `` cmd+t `` | New file |
| `` cmd+shift+t `` | New folder |
| `` cmd+w `` | Close |
| `` cmd+[ `` | Cycle left |
| `` cmd+] `` | Cycle right |
| `` cmd+b `` | Toggle file explorer |
| `` cmd+` `` | Toggle terminal |
- **tab** `-acceptSelectedSuggestion` - removes tab as the key to accept an autocomplete suggestion.
- **tab** `-editor.action.inlineSuggest.commit` - removes Tab as the key to accept an inline suggestion.
- **cmd+t** `-workbench.action.showAllSymbols` - unbinds the default <Go to Symbol> command for cmd+t.
- **cmd+t** `workbench.action.terminal.split` - splits the current terminal pane.
- **cmd+t** `explorer.newFile` `when: explorerViewletFocus` - creates a new file when the Explorer sidebar is focused.
- **cmd+w** `workbench.action.terminal.kill` `when: terminalFocus` - kills the active terminal when a terminal is focused.
- **cmd+[** `workbench.action.terminal.focusPreviousPane` `when: terminalFocus` - focuses the previous terminal pane when in the terminal.
- **cmd+]** `workbench.action.terminal.focusNextPane` `when: terminalFocus` - focuses the next terminal pane when in the terminal.
- **cmd+[** `workbench.action.previousEditor` `when: editorFocus` - navigates to the previous editor tab when in the editor.
- **cmd+]** `workbench.action.nextEditor` `when: editorFocus` - navigates to the next editor tab when in the editor.
- **cmd+b** `workbench.explorer.fileView.focus` `when: activeViewlet != explorer` - opens and focuses the Explorer sidebar when it isn't already active.
- **cmd+b** `workbench.action.focusActiveEditorGroup` `when: explorer is active OR no editorFocus` - returns focus to the active editor when the explorer is open or no editor is focused; effectively toggles focus back.
- **cmd+shift+t** `explorer.newFolder` `when: explorerViewletFocus` - creates a new folder when the explorer sidebar is focused.

---

## Contributing
This project is not currently open to contributions.