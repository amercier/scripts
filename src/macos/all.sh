#!/usr/bin/env bash

SCRIPTS=https://raw.githubusercontent.com/amercier/scripts/master/src/macos

curl -s -L $SCRIPTS/delete-dsstore-files.sh | bash
curl -s -L $SCRIPTS/install/google-chrome.sh | bash
curl -s -L $SCRIPTS/install/spectacle.sh | bash
curl -s -L $SCRIPTS/install/sublime-text.sh | bash
curl -s -L $SCRIPTS/profile.d/git-prompt-extras.sh | sudo tee /etc/profile.d/git-prompt-extras.sh >/dev/null
curl -s -L $SCRIPTS/profile.d/git-prompt.sh | sudo tee /etc/profile.d/git-prompt.sh >/dev/null
curl -s -L $SCRIPTS/profile.d/local.sh | sudo tee /etc/profile.d/local.sh >/dev/null
curl -s -L $SCRIPTS/profile.d/terminal.sh | sudo tee /etc/profile.d/terminal.sh >/dev/null
curl -s -L $SCRIPTS/profile.sh | bash
curl -s -L $SCRIPTS/tweaks.sh | bash

# HomeBrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Git
brew install git

# node.js
brew install nodejs
chown -R "$(whoami):admin" /usr/local/lib/node_modules
for package in gulp grunt bower yeoman; do
  [ -d /usr/local/lib/node_modules/$package ] \
    && echo $package is already installed \
    || npm install $package -g
done
