# mackit
optimize the macos operating system for software development.

## quick start

> **warning:** running the following commands executes all scripts in this repository. please review the changes this project makes before running on your system.

**option 1, run directly:**
```zsh
curl -s https://raw.githubusercontent.com/jaidencoleflannery/mackit/master/auto-configuration.sh | zsh
```

**option 2, clone and run locally:**
```zsh
git clone https://github.com/jaidencoleflannery/mackit.git && cd mackit && chmod +x auto-configuration.sh && ./auto-configuration.sh
```

---

## modules

> **note:** this project is a compilation of scripts, referred to as "modules" -
> following sections focus on what changes each module makes.

### vscode settings
**vscode-settings.sh:**
| setting | value | description |
|---------|-------|-------------|
| **editor.tabCompletion** | `"off"` | tab key does not cycle through autocomplete suggestions. |
| **editor.formatOnType** | `false` | code is not automatically formatted as you type. |
| **editor.formatOnPaste** | `false` | pasted code is not automatically formatted. |
| **editor.formatOnSave** | `false` | file is not automatically formatted on save. |
| **editor.hover.enabled** | `"on"` | hovering over symbols shows tooltips. |
| **security.workspace.trust.untrustedFiles** | `"open"` | files in untrusted workspaces are opened without prompting. |
| **keyboard.dispatch** | `"keyCode"` | key events are dispatched by key code rather than character, for compatibility with unorthodox layouts. |
| **git.confirmSync** | `false` | git push/pull sync runs without a confirmation dialog. |
| **workbench.startupEditor** | `"none"` | no popup is opened on startup. |
| **git.ignoreRebaseWarning** | `true` | no warning shown when a rebase is in progress. |
| **workbench.activityBar.location** | `"top"` | the activity bar is placed at the top of the sidebar instead of the side. |
| **files.exclude** | `**/.git: false` | overrides the default which hides `.git` folders, so they're visible in the explorer. |
| **editor.acceptSuggestionOnEnter** | `"off"` | enter key does not accept an autocomplete suggestion. |
| **git.openRepositoryInParentFolders** | `"never"` | vscode never detects and opens git repos found in parent directories. |
| **editor.codeActionsOnSave** | `source.fixAll: "never"` | all auto fix code actions are disabled on save. |
| **editor.codeActionsOnSave** | `source.fixAll.eslint: "never"` | eslint auto fix disabled on save. |
| **explorer.confirmDragAndDrop** | `false` | drag and drop in the explorer happen without a prompt. |

### vscode keybindings
#### general overview:
| shortcut | action |
|----------|--------|
| **cmd+t** | `` new file `` |
| **cmd+shift+t** | `` new folder `` |
| **cmd+w** | `` close `` |
| **cmd+[** | `` cycle left `` |
| **cmd+]** | `` cycle right `` |
| **cmd+b** | `` toggle file explorer `` |
| **cmd+`** | `` toggle terminal `` |

**vscode-keybindings.sh:**
| keybind | command | description |
|---------|---------|-------------|
| **tab** | <details><summary>View</summary>`-acceptSelectedSuggestion`</details> | removes tab as the key to accept an autocomplete suggestion. |
| **tab** | <details><summary>View</summary>`-editor.action.inlineSuggest.commit`</details> | removes Tab as the key to accept an inline suggestion. |
| **cmd+t** | <details><summary>View</summary>`-workbench.action.showAllSymbols`</details> | unbinds the default `go to symbol` command for cmd+t. |
| **cmd+t** | <details><summary>View</summary>`workbench.action.terminal.split`</details> | splits the current terminal pane. |
| **cmd+t** | <details><summary>View</summary>`explorer.newFile` `when: explorerViewletFocus`</details> | creates a new file when the explorer sidebar is focused. |
| **cmd+w** | <details><summary>View</summary>`workbench.action.terminal.kill` `when: terminalFocus`</details> | kills the active terminal when a terminal is focused. |
| **cmd+[** | <details><summary>View</summary>`workbench.action.terminal.focusPreviousPane` `when: terminalFocus`</details> | focuses the previous terminal pane when in the terminal. |
| **cmd+]** | <details><summary>View</summary>`workbench.action.terminal.focusNextPane` `when: terminalFocus`</details> | focuses the next terminal pane when in the terminal. |
| **cmd+[** | <details><summary>View</summary>`workbench.action.previousEditor` `when: editorFocus`</details> | navigates to the previous editor tab when in the editor. |
| **cmd+]** | <details><summary>View</summary>`workbench.action.nextEditor` `when: editorFocus`</details> | navigates to the next editor tab when in the editor. |
| **cmd+b** | <details><summary>View</summary>`workbench.explorer.fileView.focus` `when: activeViewlet != explorer`</details> | opens and focuses the explorer sidebar when it isn't already active. |
| **cmd+b** | <details><summary>View</summary>`workbench.action.focusActiveEditorGroup` `when: explorer is active OR no editorFocus`</details> | returns focus to the active editor when the explorer is open or no editor is focused; effectively toggles focus back. |
| **cmd+shift+t** | <details><summary>View</summary>`explorer.newFolder` `when: explorerViewletFocus`</details> | creates a new folder when the explorer sidebar is focused. |

### preferences
**preferences.sh:**
| setting | value | description |
|---------|-------|-------------|
| **ApplePressAndHoldEnabled** | `false` | disables the press and hold accent menu, allowing keys to repeat when held instead. |
| **KeyRepeat** | `1` | sets the key repeat rate to the fastest possible (lower = faster). |
| **InitialKeyRepeat** | `10` | sets the delay before key repeat kicks in (lower = shorter delay). |
| **com.apple.trackpad.scaling** | `3.0` | sets trackpad tracking speed to very fast. |
| **Clicking** | `true` | enables tap on the trackpad. |
| **autohide** | `true` | dock automatically hides when not in use. |
| **autohide-delay** | `0` | removes the delay before the dock toggles. |
| **autohide-time-modifier** | `0.15` | sets the dock toggle animation duration to be faster. |
| **show-recents** | `false` | hides the "recent applications" section from the dock. |
| **tilesize** | `36` | sets dock icon size to be smaller. |
| **AppleShowAllFiles** | `true` | shows hidden files (dotfiles, etc.) in finder. |
| **AppleShowAllExtensions** | `true` | always shows file extensions for all files. |
| **ShowPathbar** | `true` | shows the path bar at the bottom of finder windows. |
| **ShowStatusBar** | `true` | shows the status bar (item count, disk space) at the bottom of finder windows. |
| **FXDefaultSearchScope** | `"SCcf"` | sets default finder search scope to the current folder instead of "this mac". |
| **FXPreferredViewStyle** | `"Nlsv"` | sets default finder view to list view. |
| **DSDontWriteNetworkStores** | `true` | prevents internal mac files from being created on network volumes. |
| **DSDontWriteUSBStores** | `true` | prevents internal mac files from being created on usb drives. |
| **screencapture location** | `"$HOME/Desktop"` | saves screenshots to the desktop. |
| **screencapture type** | `"png"` | saves screenshots as png files. |
| **disable-shadow** | `true` | removes the drop shadow from window screenshots. |
| **NSAutomaticQuoteSubstitutionEnabled** | `false` | disables smart/curly quote substitution. |
| **NSAutomaticDashSubstitutionEnabled** | `false` | disables automatic em dash substitution. |
| **NSAutomaticSpellingCorrectionEnabled** | `false` | disables auto correct. |
| **NSAutomaticCapitalizationEnabled** | `false` | disables automatic capitalization of the first word in a sentence. |
| **NSAutomaticPeriodSubstitutionEnabled** | `false` | disables double space to period substitution. |
| **mru-spaces** | `false` | disables automatic reordering of spaces based on most recent use. |
| **AppleSpacesSwitchOnActivate** | `false` | prevents mac from switching to a space where an app is already open when you activate that app. |
| **Wi-Fi DNS** | `1.1.1.1, 8.8.8.8` | sets dns servers to cloudflare and google for more reliable resolution. |

### packages
**packages.sh:**
| package | description |
|---------|-------------|
| **homebrew** | installs the homebrew package manager and adds it to the shell environment. |
| **git** | version control system. |
| **node** | javascript runtime for running and building node.js applications. |
| **python** | python programming language interpreter. |
| **gcc** | gnu c/c++ compiler collection. |
| **make** | build automation tool. |
| **docker** | platform for building and running containerized applications. |
| **docker-compose** | tool for defining and running multiple container docker applications. |
| **colima** | required for macos to run a linux vm (for docker). |
| **postgresql** | relational database management system. |
| **redis** | in memory data store, typically used as a cache. |
| **sqlite** | lightweight embedded relational database. |
| **curl** | command line tool for transferring data with urls. |
| **jq** | command line json processor (required for some contained scripts). |
| **dotnet** | .net sdk for building and running .net applications. |

---

## contributing
this project is not currently open to contributions.
