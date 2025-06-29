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
PS1='\t \w \$ '

# infinite .bash_history
HISTSIZE=
HISTFILESIZE=

export EDITOR=vim

# automatically change directories if a directory is the sole argument
shopt -s autocd

## ALIASES ##

alias ll='ls -lah'
alias la='ls -a'

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gl='git log'
alias gpll='git pull'
alias gpsh='git push'

# list unique history
alias uhist='history | awk "{\$1=\"\"; print substr(\$0,2)}" | sort -u'

# up X (where X is a number) to go up X directories
up() { cd $(eval printf '../'%.0s {1..$1}); }
