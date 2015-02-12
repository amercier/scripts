#!/usr/bin/env bash --login

source $(brew --prefix nvm)/nvm.sh
export NVM_DIR=~/.nvm
export PATH=./node_modules/.bin:$PATH
nvm use default >/dev/null
