echo .zshrc

# Source ~/.bash_aliases
if [ -e "$HOME/.bash_aliases" ]; then
  source "$HOME/.bash_aliases"
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /Users/amercier/.travis/travis.sh ] && source /Users/amercier/.travis/travis.sh
