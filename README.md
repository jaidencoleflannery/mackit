# mackit
Optimize the macOS operating system for software development efficiency.

<br>

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

<br>

---

<br>

## Modules

> **Note:** This project is a compilation of scripts, referred to as "modules" -
> following sections focus on what changes each module makes.

<br>

### VSCode Settings
**vscode-settings.sh:**
| Setting | Value | Description |
|---------|-------|-------------|
| **editor.tabCompletion** | `"off"` | Tab key does not cycle through autocomplete suggestions. |
| **editor.formatOnType** | `false` | Code is not automatically formatted as you type. |
| **editor.formatOnPaste** | `false` | Pasted code is not automatically formatted. |
| **editor.formatOnSave** | `false` | File is not automatically formatted on save. |
| **editor.hover.enabled** | `"on"` | Hovering over symbols shows tooltips. |
| **security.workspace.trust.untrustedFiles** | `"open"` | Files in untrusted workspaces are opened without prompting. |
| **keyboard.dispatch** | `"keyCode"` | Key events are dispatched by key code rather than character, for compatibility with unorthodox layouts. |
| **git.confirmSync** | `false` | Git push/pull sync runs without a confirmation dialog. |
| **workbench.startupEditor** | `"none"` | No popup is opened on startup. |
| **git.ignoreRebaseWarning** | `true` | No warning shown when a rebase is in progress. |
| **workbench.activityBar.location** | `"top"` | The activity bar is placed at the top of the sidebar instead of the side. |
| **files.exclude** | `**/.git: false` | Overrides the default which hides `.git` folders, so they're visible in the Explorer. |
| **editor.acceptSuggestionOnEnter** | `"off"` | Enter key does not accept an autocomplete suggestion. |
| **git.openRepositoryInParentFolders** | `"never"` | VSCode never detects and opens git repos found in parent directories. |
| **editor.codeActionsOnSave** | `source.fixAll: "never"` | All auto fix code actions are disabled on save. |
| **editor.codeActionsOnSave** | `source.fixAll.eslint: "never"` | ESLint auto fix disabled on save. |
| **explorer.confirmDragAndDrop** | `false` | Drag and drop in the Explorer happen without a prompt. |

<br>

---

<br>

### VSCode Keybindings

#### Overview:
| Shortcut | Action |
|----------|--------|
| **cmd+t** | `` New file `` |
| **cmd+shift+t** | `` New folder `` |
| **cmd+w** | `` Close `` |
| **cmd+[** | `` Cycle left `` |
| **cmd+]** | `` Cycle right `` |
| **cmd+b** | `` Toggle file explorer `` |
| **cmd+`** | `` Toggle terminal `` |

**vscode-keybindings.sh:**

| Keybind | Command | Description |
|---------|---------|-------------|
| **tab** | <details><summary>View</summary>`-acceptSelectedSuggestion`</details> | Removes tab as the key to accept an autocomplete suggestion. |
| **tab** | <details><summary>View</summary>`-editor.action.inlineSuggest.commit`</details> | Removes Tab as the key to accept an inline suggestion. |
| **cmd+t** | <details><summary>View</summary>`-workbench.action.showAllSymbols`</details> | Unbinds the default Go to Symbol command for cmd+t. |
| **cmd+t** | <details><summary>View</summary>`workbench.action.terminal.split`</details> | Splits the current terminal pane. |
| **cmd+t** | <details><summary>View</summary>`explorer.newFile` `when: explorerViewletFocus`</details> | Creates a new file when the Explorer sidebar is focused. |
| **cmd+w** | <details><summary>View</summary>`workbench.action.terminal.kill` `when: terminalFocus`</details> | Kills the active terminal when a terminal is focused. |
| **cmd+[** | <details><summary>View</summary>`workbench.action.terminal.focusPreviousPane` `when: terminalFocus`</details> | Focuses the previous terminal pane when in the terminal. |
| **cmd+]** | <details><summary>View</summary>`workbench.action.terminal.focusNextPane` `when: terminalFocus`</details> | Focuses the next terminal pane when in the terminal. |
| **cmd+[** | <details><summary>View</summary>`workbench.action.previousEditor` `when: editorFocus`</details> | Navigates to the previous editor tab when in the editor. |
| **cmd+]** | <details><summary>View</summary>`workbench.action.nextEditor` `when: editorFocus`</details> | Navigates to the next editor tab when in the editor. |
| **cmd+b** | <details><summary>View</summary>`workbench.explorer.fileView.focus` `when: activeViewlet != explorer`</details> | Opens and focuses the Explorer sidebar when it isn't already active. |
| **cmd+b** | <details><summary>View</summary>`workbench.action.focusActiveEditorGroup` `when: explorer is active OR no editorFocus`</details> | Returns focus to the active editor when the explorer is open or no editor is focused; effectively toggles focus back. |
| **cmd+shift+t** | <details><summary>View</summary>`explorer.newFolder` `when: explorerViewletFocus`</details> | Creates a new folder when the explorer sidebar is focused. |

<br>

---

<br>

### Preferences
**preferences.sh:**
| Setting | Value | Description |
|---------|-------|-------------|
| **ApplePressAndHoldEnabled** | `false` | Disables the press and hold accent menu, allowing keys to repeat when held instead. |
| **KeyRepeat** | `1` | Sets the key repeat rate to the fastest possible (lower = faster). |
| **InitialKeyRepeat** | `10` | Sets the delay before key repeat kicks in (lower = shorter delay). |
| **com.apple.trackpad.scaling** | `3.0` | Sets trackpad tracking speed to very fast. |
| **Clicking** | `true` | Enables tap on the trackpad. |
| **autohide** | `true` | Dock automatically hides when not in use. |
| **autohide-delay** | `0` | Removes the delay before the dock toggles. |
| **autohide-time-modifier** | `0.15` | Sets the dock toggle animation duration to be faster. |
| **show-recents** | `false` | Hides the "recent applications" section from the dock. |
| **tilesize** | `36` | Sets dock icon size to 36px. |
| **AppleShowAllFiles** | `true` | Shows hidden files (dotfiles, etc.) in Finder. |
| **AppleShowAllExtensions** | `true` | Always shows file extensions for all files. |
| **ShowPathbar** | `true` | Shows the path bar at the bottom of Finder windows. |
| **ShowStatusBar** | `true` | Shows the status bar (item count, disk space) at the bottom of Finder windows. |
| **FXDefaultSearchScope** | `"SCcf"` | Sets default Finder search scope to the current folder instead of "This Mac". |
| **FXPreferredViewStyle** | `"Nlsv"` | Sets default Finder view to list view. |
| **DSDontWriteNetworkStores** | `true` | Prevents internal Mac files from being created on network volumes. |
| **DSDontWriteUSBStores** | `true` | Prevents internal Mac files from being created on USB drives. |
| **screencapture location** | `"$HOME/Desktop"` | Saves screenshots to the desktop. |
| **screencapture type** | `"png"` | Saves screenshots as PNG files. |
| **disable-shadow** | `true` | Removes the drop shadow from window screenshots. |
| **NSAutomaticQuoteSubstitutionEnabled** | `false` | Disables smart/curly quote substitution. |
| **NSAutomaticDashSubstitutionEnabled** | `false` | Disables automatic em dash substitution. |
| **NSAutomaticSpellingCorrectionEnabled** | `false` | Disables auto correct. |
| **NSAutomaticCapitalizationEnabled** | `false` | Disables automatic capitalization of the first word in a sentence. |
| **NSAutomaticPeriodSubstitutionEnabled** | `false` | Disables double space to period substitution. |
| **mru-spaces** | `false` | Disables automatic reordering of spaces based on most recent use. |
| **AppleSpacesSwitchOnActivate** | `false` | Prevents Mac from switching to a space where an app is already open when you activate that app. |
| **Wi-Fi DNS** | `1.1.1.1, 8.8.8.8` | Sets DNS servers to Cloudflare and Google for more reliable resolution. |

<br>

---

<br>

### Packages
**packages.sh:**
| Package | Description |
|---------|-------------|
| **homebrew** | Installs the Homebrew package manager and adds it to the shell environment. |
| **git** | Version control system. |
| **node** | JavaScript runtime for running and building Node.js applications. |
| **python** | Python programming language interpreter. |
| **gcc** | GNU C/C++ compiler collection. |
| **make** | Build automation tool. |
| **docker** | Platform for building and running containerized applications. |
| **docker-compose** | Tool for defining and running multi-container Docker applications. |
| **colima** | Required for macOS to run a Linux VM for Docker. |
| **postgresql** | Relational database management system. |
| **redis** | In-memory data structure store, used as a database and cache. |
| **sqlite** | Lightweight embedded relational database. |
| **curl** | Command-line tool for transferring data with URLs. |
| **jq** | Command-line JSON processor; required for later scripts. |
| **dotnet** | .NET SDK for building and running .NET applications. |

---

## Contributing
This project is not currently open to contributions.