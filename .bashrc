# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## FUNCTIONS ##

# Check if a command exists
cmd_exists () {
  type "$1" >> /dev/null 2>&1 ;
}

## SETTINGS ##

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Minimal prompt
if [ "$(whoami)" = "root" ]; then
  PS1=' \W # '
else
  PS1=' \W $ '
fi

# Don't put duplicate lines in history
# HISTCONTROL=ignoredups

# Infinite .bash_history
HISTSIZE=
HISTFILESIZE=

# Automatically change directories if a directory is the sole argument
shopt -s autocd

# Readline completes if it matches with the current prefix
# bind '"\e[A"':history-search-backward 2> /dev/null
# bind '"\e[B"':history-search-forward 2> /dev/null
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

## ALIASES ##

# Run personal enviro. by default
alias sudo='sudo -E'
alias root='sudo'

# sudo the last command
alias fuck='sudo $(history -p \!\!)'
