## SETTINGS ##

# set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# minimal prompt
# PS1 = [grey]HH:MM [green]directory [red]prompt sign
# optional yellow username: '\[\e[38;5;220m\]\u\[\e[0m\]'
PS1='\[\e[38;5;102m\]\A\[\e[0m\] \[\e[38;5;154m\]\w\[\e[0m\] \[\e[38;5;197m\]\$\[\e[0m\] '

# infinite .bash_history
HISTSIZE=
HISTFILESIZE=

if command -v "nvim" &>/dev/null; then
    veditor=nvim
else
    veditor=vim
fi
export EDITOR=$veditor

# automatically change directories if a directory is the sole argument
shopt -s autocd

## ALIASES ##

alias ..='cd ..'

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
alias uhist='history | awk "{\$1=\"\"; print substr(\$0,2)}" | awk "!seen[\$0]++"'

# up X to go up X directories
up() { cd $(eval printf '../'%.0s {1..$1}); }
