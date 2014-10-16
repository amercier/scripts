#!/usr/bin/env bash

# Disable .DS_Store files
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool true

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Disable "natural" (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Disable smart quotes as it's annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

echo "Done. Note that some of these changes require a logout/restart to take effect."