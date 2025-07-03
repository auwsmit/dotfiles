## SETTINGS ##

# pretty minimal prompt
# PS1 = [grey]HH:MM [green]directory [red]prompt sign
# optional yellow username: '\[\e[38;5;220m\]\u\[\e[0m\]'
PS1='\[\e[38;5;102m\]\A\[\e[0m\] \[\e[38;5;154m\]\w\[\e[0m\] \[\e[38;5;197m\]\$\[\e[0m\] '

# disable ctrl-s
stty -ixon

# automatically change directories if a directory is the sole argument
shopt -s autocd

# infinite .bash_history
HISTSIZE= HISTFILESIZE=

if command -v "nvim" &>/dev/null; then
    bashrc_editor=nvim
else
    bashrc_editor=vim
fi
export EDITOR=$bashrc_editor

# set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

## ALIASES ##

alias ..='cd ..'

alias ll='ls -lah'
alias la='ls -a'

# sudo with personal env and aliases
alias sume='sudo -E '

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gl='git log'
alias gp='git pull'
alias gP='git push'

# simple list of unique history
alias uhist='history | awk "{\$1=\"\"; print substr(\$0,2)}" | awk "!seen[\$0]++"'

# synchronize Windows and WSL dotfiles at the same time
bashrc_sync_wsl_dotfiles() {
    local temp_wd=$(pwd)
    if [ -e /mnt/y/Git/dotfiles ]; then
        cd /mnt/y/Git/dotfiles
        git pull
    fi
    if [ -e ~/git/dotfiles ]; then
        cd ~/git/dotfiles
        git pull
    fi
    cd $temp_wd
}
if command -v "cmd.exe" &>/dev/null; then
    alias gsync='bashrc_sync_wsl_dotfiles'
    alias cdwd='cd /mnt/y/Git/dotfiles'
fi
alias cdd='cd ~/git/dotfiles'

# up X to go up X directories
up() { cd $(eval printf '../'%.0s {1..$1}); }


## CLEAN-UP ##
unset bashrc_editor
