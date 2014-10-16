#!/usr/bin/env bash

# Add ~/.rvm.bin to the PATH
export PATH="$PATH:$HOME/.rvm/bin"

# Initialize RVM environment
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
