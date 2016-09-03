# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## FUNCTIONS ##

# Check if a command exists
command_exists () {
  type "$1" >> /dev/null 2>&1 ;
}

# Actually remove/purge apt metapackages
aptmeta () {
  sudo apt-get $1 --auto-remove  $(apt-cache depends $2 | cut -f 2 -d ':' | grep -v \< | tr '\n' ' ') ;
}

# Ask for confirmation to startx
confirm_startx () {
  echo
  read -p "Start X Server? (y or n) " -n 1 -r
  case "$REPLY" in
    y|Y ) exec startx;;
    * ) echo;;
  esac
}

## SETTINGS ##

# Minimal prompt:
PS1=' \W $ '

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

## ALIASES ##

alias battery='acpi'

# Run personal enviro. by default
alias sudo='sudo -E'
alias root='sudo'
alias fucking='sudo'

# one instance of emacs/vim
# and single letter shortcuts are cool too
alias e='emacsclient -n'
alias v='vim --remote-silent'

# Battery info
alias battery='acpi'

# Package management
if command_exists apt ; then
  alias update='sudo apt update'
  alias install='sudo apt update && sudo apt install --auto-remove'
  alias uninstall='sudo apt remove --auto-remove'
  alias purge='sudo apt purge --auto-remove'
  alias search='apt-cache search'
  alias full-upgrade='sudo apt update && sudo apt full-upgrade'
fi

## XINIT/STARTX ##

# Auto-run startx on virtual terminal 1, since it's the default VT
if command_exists startx ; then
  # for systemd:
  if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 ]]; then
    confirm_startx
  fi
  # for non-systemd:
  if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    confirm_startx
  fi
fi
