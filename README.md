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

| Keybind | Command | Description |
|---------|---------|-------------|
| **tab** | `-acceptSelectedSuggestion` | <details><summary>Click to view.</summary>Removes tab as the key to accept an autocomplete suggestion.</details> |
| **tab** `-editor.action.inlineSuggest.commit` - removes Tab as the key to accept an inline suggestion.
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

### Preferences
**preferences.sh:**
- **ApplePressAndHoldEnabled** `false` - disables the press and hold accent menu, allowing keys to repeat when held instead.
- **KeyRepeat** `1` - sets the key repeat rate to the fastest possible (lower = faster).
- **InitialKeyRepeat** `10` - sets the delay before key repeat kicks in (lower = shorter delay).
- **com.apple.trackpad.scaling** `3.0` - sets trackpad tracking speed to very fast.
- **Clicking** `true` - enables tap on the trackpad.
- **autohide** `true` - dock automatically hides when not in use.
- **autohide-delay** `0` - removes the delay before the dock toggles.
- **autohide-time-modifier** `0.15` - sets the dock toggle animation duration to be faster.
- **show-recents** `false` - hides the "recent applications" section from the dock.
- **tilesize** `36` - sets dock icon size to 36px.
- **AppleShowAllFiles** `true` - shows hidden files (dotfiles, etc.) in finder.
- **AppleShowAllExtensions** `true` - always shows file extensions for all files.
- **ShowPathbar** `true` - shows the path bar at the bottom of finder windows.
- **ShowStatusBar** `true` - shows the status bar (item count, disk space) at the bottom of finder windows.
- **FXDefaultSearchScope** `"SCcf"` - sets default finder search scope to the current folder instead of "this mac".
- **FXPreferredViewStyle** `"Nlsv"` - sets default finder view to list view.
- **DSDontWriteNetworkStores** `true` - prevents internal mac files from being created on network volumes.
- **DSDontWriteUSBStores** `true` - prevents internal mac files from being created on usb drives.
- **screencapture location** `"$HOME/Desktop"` - saves screenshots to the desktop.
- **screencapture type** `"png"` - saves screenshots as png files.
- **disable-shadow** `true` - removes the drop shadow from window screenshots.
- **NSAutomaticQuoteSubstitutionEnabled** `false` - disables smart/curly quote substitution.
- **NSAutomaticDashSubstitutionEnabled** `false` - disables automatic em dash substitution.
- **NSAutomaticSpellingCorrectionEnabled** `false` - disables auto correct.
- **NSAutomaticCapitalizationEnabled** `false` - disables automatic capitalization of the first word in a sentence.
- **NSAutomaticPeriodSubstitutionEnabled** `false` - disables double space to period substitution.
- **mru-spaces** `false` - disables automatic reordering of spaces based on most recent use.
- **AppleSpacesSwitchOnActivate** `false` - prevents mac from switching to a space where an app is already open when you activate that app.
- **Wi-Fi DNS** `1.1.1.1, 8.8.8.8` - sets dns servers to cloudflare and google for a more reliable resolution.

---

## Contributing
This project is not currently open to contributions.