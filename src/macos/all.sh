#!/usr/bin/env bash

SCRIPTS=https://raw.githubusercontent.com/amercier/scripts/master/src/macos

curl -s -L $SCRIPTS/delete-dsstore-files.sh | bash
curl -s -L $SCRIPTS/install/google-chrome.sh | bash
curl -s -L $SCRIPTS/install/spectacle.sh | bash
curl -s -L $SCRIPTS/install/sublime-text.sh | bash
curl -s -L $SCRIPTS/java6-plugin-for-chrome.sh | bash
curl -s -L $SCRIPTS/keys.sh | bash
curl -s -L $SCRIPTS/profile.d/git-prompt-extras.sh | bash
curl -s -L $SCRIPTS/profile.d/git-prompt.sh | bash
curl -s -L $SCRIPTS/profile.d/local.sh | bash
curl -s -L $SCRIPTS/profile.d/mysql.sh | bash
curl -s -L $SCRIPTS/profile.d/terminal.sh | bash
curl -s -L $SCRIPTS/profile.sh | bash
curl -s -L $SCRIPTS/tweaks.sh | bash

# HomeBrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Git
brew install git