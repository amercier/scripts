#!/usr/bin/env bash

git-dirty() {
    git status >/dev/null 2>&1 || return

    st=$(git status 2>/dev/null | tail -n 1)
    if [[ $st != "nothing to commit, working directory clean" ]]
    then
        echo "*"
    fi
}

git-behind() {
    git status >/dev/null 2>&1 || return

    # get the tracking-branch name
    tracking_branch=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
    [ "$tracking_branch" != "" ] || return

    # creates global variables $1 and $2 based on left vs. right tracking
    # inspired by @adam_spiers
    set -- $(git rev-list --left-right --count $tracking_branch...HEAD)

    if [ "$1" != "0" ]; then echo -n -e "-$1"; fi
}

git-ahead() {
    git status >/dev/null 2>&1 || return

    # get the tracking-branch name
    tracking_branch=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
    [ "$tracking_branch" != "" ] || return

    # creates global variables $1 and $2 based on left vs. right tracking
    # inspired by @adam_spiers
    set -- $(git rev-list --left-right --count $tracking_branch...HEAD)

    if [ "$2" != "0" ]; then echo -n -e "+$2"; fi
}
