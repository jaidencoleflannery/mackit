#!/bin/zsh

echo -e "\n[ Mackit ] ~ Configuring MacOS preferences."

# if ran from a parent, do not print
CHILD=$1

# key repeat
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10

# trackpad
defaults write -g com.apple.trackpad.scaling -float 3.0
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.15
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 36

# finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# screenshots
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# text input
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

# mission control
defaults write com.apple.dock mru-spaces -bool false
defaults write -g AppleSpacesSwitchOnActivate -bool false

# dns
sudo networksetup -setdnsservers Wi-Fi 1.1.1.1 8.8.8.8

# required to run to actually enable this stuff 
killall Dock Finder SystemUIServer cfprefsd

if [ "$CHILD" != true ]; then
    echo "\n[ Mackit - Preferences ]\n~ This script optimized your MacOS preferences for efficiency.\n~ If you found this useful, please leave a star on the project: https://github.com/jaidencoleflannery/mackit \n"
fi