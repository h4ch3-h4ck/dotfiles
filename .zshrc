# Path to your oh-my-zsh installation.
export ZSH=/Users/luismendoza/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(rails git)

# User configuration

export PATH="$PATH:/Users/luismendoza/.rvm/gems/ruby-2.1.2/bin:/Users/luismendoza/.rvm/gems/ruby-2.1.2@global/bin:/Users/luismendoza/.rvm/rubies/ruby-2.1.2/bin:/Users/luismendoza/.rbenv/shims:/usr/local/bin:/Users/luismendoza/Dev/google-cloud-sdk/bin:/usr/local/heroku/bin:/Users/luismendoza/.rbenv/shims:/Users/luismendoza/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/Users/luismendoza/.rvm/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Personal aliases
alias ~="cd ~"
alias reload="source ~/.zshrc"
alias dev="cd Sandbox/"
alias personal="cd Sandbox/Personal"
alias kiwi="cd Sandbox/Kiwi/"
alias web="cd Sandbox/Kiwi/web"
alias admin="cd Sandbox/Kiwi/admin"
alias api="cd Sandbox/Kiwi/appengine/src/kiwi"
alias beek="cd Sandbox/Beek/beek_core"
alias savetorepo="cp -r ~/.oh-my-zsh ~/Sandbox/Personal/dotfiles/; cp ~/.zshrc ~/Sandbox/Personal/dotfiles; cp ~/.bash_profile ~/Sandbox/Personal/dotfiles"