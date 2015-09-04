#!/bin/bash
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

## Make terminal pretty
export PS1="\n \w [\u] @ \h \[\033[32m\]\$(parse_git_branch)\[\033[00m\] \n $ "
export PS2=" $ "

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
