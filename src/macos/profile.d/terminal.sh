#!/usr/bin/env bash

export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export COLOR_NC='\e[0m' # No Color
[ -f "$HOME/.bashrc" ]       && . "$HOME/.bashrc"
[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"
export PS1='[\u@\h \[\033[1;36m\]\w\[\033[0m\]$(__git_ps1 " \[\033[1;32m\]%s\[\033[0m\]")\[\033[1;31m\]$(git-behind)\[\033[1;33m\]$(git-ahead)\[\033[0;31m\]$(git-dirty)\[\033[0m\]]\$ '
