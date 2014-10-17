#!/usr/bin/env bash

SCRIPTS=https://raw.githubusercontent.com/amercier/scripts/master/src/macos

curl -s -L $SCRIPTS/tweaks.sh | bash
if [ "$(defaults read com.apple.desktopservices DSDontWriteNetworkStores)" == "false" ]; then
  curl -s -L $SCRIPTS/delete-dsstore-files.sh | bash
fi

xcode-select --install

curl -s -L $SCRIPTS/profile.d/git-prompt-extras.sh | sudo tee /etc/profile.d/git-prompt-extras.sh >/dev/null
curl -s -L $SCRIPTS/profile.d/git-prompt.sh | sudo tee /etc/profile.d/git-prompt.sh >/dev/null
curl -s -L $SCRIPTS/profile.d/local.sh | sudo tee /etc/profile.d/local.sh >/dev/null
curl -s -L $SCRIPTS/profile.d/nvm.sh | sudo tee /etc/profile.d/nvm.sh >/dev/null
curl -s -L $SCRIPTS/profile.d/terminal.sh | sudo tee /etc/profile.d/terminal.sh >/dev/null
curl -s -L $SCRIPTS/profile.sh | bash

curl -s -L $SCRIPTS/install/google-chrome.sh | bash
curl -s -L $SCRIPTS/install/spectacle.sh | bash
curl -s -L $SCRIPTS/install/sublime-text.sh | bash

# HomeBrew
which brew >/dev/null && echo "Brew is already installed" || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Git
brew install git

# node.js
brew install nvm
nvm install $(curl -L -s http://nodejs.org/ | grep Current | egrep -o 'v[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)

for package in gulp grunt bower yo generator-angular; do
  [ -d $NODE_PATH/$package ] && echo $package is already installed || npm install $package -g
done

# Ruby
which rvm >/dev/null && echo "RVM is already installed" || curl -sSL https://get.rvm.io | bash -s stable
rvm install $(curl -s -L https://www.ruby-lang.org/en/downloads/ | grep stable | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)
for gem in rails-api; do
  [ -d $GEM_HOME/bin/$gem ] && echo $gem is already installed || gem install $gem
done