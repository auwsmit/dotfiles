## SETTINGS ##

# pretty minimal prompt
# PS1 = [grey]HH:MM [green]directory [red]prompt sign
# optional yellow username: '\[\e[38;5;220m\]\u\[\e[0m\]'
PS1='\[\e[38;5;102m\]\A\[\e[0m\] \[\e[38;5;154m\]\w\[\e[0m\] \[\e[38;5;197m\]\$\[\e[0m\] '

# disable ctrl-s
stty -ixon

# automatically change directories if directory is the sole argument
shopt -s autocd

# infinite .bash_history
HISTSIZE= HISTFILESIZE=

if command -v "nvim" &>/dev/null; then
    bashrc_editor=nvim
else
    bashrc_editor=vim
fi
export EDITOR=$bashrc_editor
unset bashrc_editor

# set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

## ALIASES ##

# safer file management
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias mkdir='mkdir -vp'
alias rmdir='rmdir -v'

# human readable, seriously why isn't this the default
alias du='du -h'
alias df='df -h'
alias free='free -h'

# colors
alias ls='ls --color=auto'
alias less='less --use-color'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# shortcuts
alias ..='cd ..'
alias ll='ls --color=auto -lAh'
alias la='ls --color=auto -A'
alias e='$EDITOR'
alias q='exit'

# git shortcuts
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gu='git restore --staged'
alias gc='git commit'
alias gcm='git commit -m'
alias gl='git log'
alias gL='git log --oneline --graph --decorate'
alias gp='git pull'
alias gP='git push'
alias gb='git branch'
alias gco='git checkout'

# sudo with personal env and aliases
alias sume='sudo -E '

# simple list of unique history
alias uhist='history | awk "{\$1=\"\"; print substr(\$0,2)}" | awk "!seen[\$0]++"'

# up X to go up X directories
up() { cd $(eval printf '../'%.0s {1..$1}); }

# cd dotfiles
alias cdd='cd ~/git/dotfiles'

# WSL specific mappings
if command -v "cmd.exe" &>/dev/null; then
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
    alias gsync='bashrc_sync_wsl_dotfiles'
    alias cdwd='cd /mnt/y/Git/dotfiles'
    alias dir='cmd.exe /c dir.exe'
    alias pwsh='powershell.exe'
    alias pwshc='powershell.exe -Command'
    alias cmd='cmd.exe'
    alias cmdc='cmd.exe /c'
else
    unset bashrc_sync_wsl_dotfiles
fi

