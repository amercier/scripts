#!/bin/bash
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export COLOR_NC='\e[0m' # No Color
[ -f "$HOME/.bashrc" ]       && . "$HOME/.bashrc"
[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"
