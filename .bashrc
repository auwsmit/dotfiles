# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## FUNCTIONS

# Check if a command exists
command_exists () {
  type "$1" 1> /dev/null ;
}

## SETTINGS

# Minimal prompt:
#   Current directory name and shell level (when shlvl > 1)
PS1=' \W $(((SHLVL>1)) && echo "["$SHLVL"] ")$\[\e[0m\] '

# Don't put duplicate lines in history
HISTCONTROL=ignoredups

# Infinite .bash_history
HISTSIZE=
HISTFILESIZE=

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Readline completes if it matches with the current prefix
bind '"\e[A"':history-search-backward 2> /dev/null
bind '"\e[B"':history-search-forward 2> /dev/null

# Remap caps lock to control
xmodmap -e 'keycode 66 = Control_L' 2> /dev/null
xmodmap -e 'clear Lock' 2> /dev/null
xmodmap -e 'add Control = Control_L' 2> /dev/null

## ALIASES ##

alias battery='acpi'

# Run personal enviro. by default
alias sudo='sudo -E'
alias root='sudo'
alias fucking='sudo'

# Package management
if command_exists apt ; then
  alias update='sudo apt update'
  alias install='sudo apt update && sudo apt install'
  alias uninstall='sudo apt remove'
  alias purge='sudo apt purge'
  alias search='apt-cache search'
  alias full-upgrade='sudo apt update && sudo apt full-upgrade'
fi
