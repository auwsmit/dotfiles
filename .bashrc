# do not continue if not in a bash shell
[ -z "$BASH_VERSION" ] && return

# do not continue if not running interactively
[ -z "$PS1" ] && return

## FUNCTIONS

# check if a command exists
command_exists () {
  type "$1" 2> /dev/null ;
}

## SETTINGS

# minimal prompt:
#   current directory name and shell level (when > 1)
PS1=' \W $(((SHLVL>1)) && echo "["$SHLVL"] ")$\[\e[0m\] '

# infinite .bash_history
HISTSIZE=
HISTFILESIZE=

# readline completes if it matches with the current prefix
bind '"\e[A"':history-search-backward 2> /dev/null
bind '"\e[B"':history-search-forward 2> /dev/null

# remap caps lock to control
# xmodmap -e 'keycode 66 = Control_L' 2> /dev/null
# xmodmap -e 'clear Lock' 2> /dev/null
# xmodmap -e 'add Control = Control_L' 2> /dev/null

## ALIASES ##

# run personal enviro. by default
alias sudo='sudo -E'
alias woodo='sudo'

# package management
if command_exists apt ; then
  alias update='sudo apt-get update'
  alias install='sudo apt-get install'
  alias uninstall='sudo apt-get remove'
  alias purge='sudo apt-get purge'
  alias search='apt-cache search'
  alias full-upgrade='sudo apt-get update && sudo apt-get dist-upgrade'
fi
