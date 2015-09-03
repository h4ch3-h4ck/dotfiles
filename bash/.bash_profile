#!/bin/bash

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

## Make terminal pretty
export PS1="\n \w [\u] @ \h \[\033[32m\]\$(parse_git_branch)\[\033[00m\] \n $ "
export PS2=" $ "

## Navigation Commands
alias ls="ls -l"
alias ssh="ssh -l"
alias ~="cd ~"

# Personal aliases
alias dotfiles="cd ~/dev/config/dotfiles"
alias dev="cd ~/dev"
alias personal="cd ~/dev/personal"
alias kiwi="cd ~/dev/kiwi"
alias web="cd ~/dev/kiwi/web"
alias admin="cd ~/dev/kiwi/admin"
alias api="cd ~/dev/kiwi/appengine/src/kiwi"
alias beek="cd ~/dev/clientes/beek/beek_core"

## Postgres Commands
alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias pgstatus="pg_ctl -D /usr/local/var/postgres status"

#Solr Commands
alias solrstart="bundle exec sunspot-solr start"
alias solrrun="bundle exec sunspot-solr run"
alias solrstop="bundle exec sunspot-solr stop"

## Rails
alias be="bundle exec"
alias bi="bundle install"
alias r='rails'
alias rg='rails g'
alias rs='rails s'
alias rc='rails c'
alias rn='rails new'
alias rd='rails dbconsole'
alias rp='rails plugin'
alias ra='rails application'
alias rd='rails destroy'

## rake
alias rt='rake test'
alias rtu='rake test:units'
alias rtf='rake test:functionals'
alias rti='rake test:integration'
alias rr='rake routes'
alias rdbm='rake db:migrate'
alias rdbr='rake db:rollback'

## Flush DNS Cache
alias flushDNS='dscacheutil -flushcache'

## Reload Terminal
alias reload='source ~/.bash_profile'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/luismendoza/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/Users/luismendoza/google-cloud-sdk/completion.bash.inc'

# Export ENV variables for Kiwi
export KIWI_SMTP_USER="hola@usekiwi.com"
export KIWI_SMTP_PASSWORD="[REDACTED]"
export GOPATH="/Users/luismendoza/dev/kiwi/appengine"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
