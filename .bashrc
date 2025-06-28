# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## SETTINGS ##

# set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# minimal prompt
PS1='[\u] \W \$ '

# infinite .bash_history
HISTSIZE=
HISTFILESIZE=

# automatically change directories if a directory is the sole argument
shopt -s autocd

## ALIASES ##

alias ll='ls -lah'
alias la='la -a'

# list unique history
alias uhist='history | awk "{\$1=\"\"; print substr(\$0,2)}" | sort -u'
