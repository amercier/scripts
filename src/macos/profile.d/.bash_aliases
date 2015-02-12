alias cdss='cwd="$(pwd)"; cd ~/Workspace/Bijli ; vagrant up sscentos; vagrant ssh sscentos -- -t cd "$(echo $cwd | sed s/\\/Users\\/$(whoami)/\\/home\\/vagrant/); bash --login"; cd "$cwd"'
alias vi=vim
alias h10='head -n 10'
alias h20='head -n 20'
alias h30='head -n 30'
alias h40='head -n 40'
alias h50='head -n 50'
alias h60='head -n 60'
alias h70='head -n 70'
alias h80='head -n 80'
alias h90='head -n 90'
alias h100='head -n 100'

# Git aliases
alias gl='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias gll='gl | h10'
alias gl-full='git log --graph --pretty=format:'\''%Cred%H%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias gs='git status'
alias gd='git diff'
alias gdc='gd --cached'

alias bower-list="node -e 'console.log(Object.keys(require(\"./bower.json\").dependencies || {}).join(\" \"));'"
alias bower-list-dev="node -e 'console.log(Object.keys(require(\"./bower.json\").devDependencies || {}).join(\" \"));'"

# Slideshare aliases
alias ss-review-default='ss-review --reviewers=distro_codereview@slideshare.com,jean@slideshare.com,dennis@slideshare.com,ana@slideshare.com,benjamin@slideshare.com,valerie@slideshare.com,owen@slideshare.com,gabriel@slideshare.com --send_mail'
alias ss-tunnel='ssh -L '\''*:3307:stghitsmasterdb01.sl.ss:3306'\'' amercier@ops03.sl.ss -Nf'

# LinkedIn aliases
alias li-npm='npm --always-auth true --registry https://artifactory.corp.linkedin.com:8083/artifactory/api/npm/npm-local'
# alias npm-public='npm --always-auth false  --registry http://registry.npmjs.org'

function ss-api {
  ts=$(date +%s)
  key=yAlh3N3S
  secret=KGDa8yTE
  echo -n "?api_key=$key"
  echo -n "&ts=$ts"
  echo -n "&hash=$(echo -n "$secret$ts" | openssl sha1)"
  echo
}
