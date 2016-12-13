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
# (buggy)
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

# Minimal prompt
if [ "$(whoami)" = "root" ]; then
  PS1=' \W # '
else
  PS1=' \W $ '
fi

# Don't put duplicate lines in history
HISTCONTROL=ignoredups

# Infinite .bash_history
HISTSIZE=
HISTFILESIZE=

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Automatically change directories if a directory is the sole argument
shopt -s autocd

# Readline completes if it matches with the current prefix
# bind '"\e[A"':history-search-backward 2> /dev/null
# bind '"\e[B"':history-search-forward 2> /dev/null
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

## ALIASES ##

alias battery='acpi'

# Run personal enviro. by default
alias sudo='sudo -E'
alias root='sudo'

# sudo the last command
alias fuck='sudo $(history -p \!\!)'

# one instance of emacs/vim
# and single letter shortcuts are cool too
alias e='emacsclient -n'
alias v='vim --remote-silent'

# Brightness adjustment
# (bl for BackLight)
sys_backlight=/sys/class/backlight/*
max_bright=$(cat $sys_backlight/max_brightness)
alias bl_max="sudo bash -c \"echo $max_bright > $sys_backlight/brightness\""
alias bl_mid="sudo bash -c \"echo $(($max_bright/2)) > $sys_backlight/brightness\""
alias bl_low="sudo bash -c \"echo $(($max_bright/10)) > $sys_backlight/brightness\""
alias bl_lower="sudo bash -c \"echo $(($max_bright/15)) > $sys_backlight/brightness\""

# Battery info
alias battery='acpi'

# Package management
if command_exists apt ; then
  alias pacu='sudo apt update'
  alias paci='sudo apt update; sudo apt install --auto-remove'
  alias pacr='sudo apt remove --auto-remove'
  alias pacp='sudo apt purge --auto-remove'
  alias pacs='apt-cache search'
  alias pacfu='sudo apt update; sudo apt full-upgrade; sudo apt -y autoremove'
fi

## XINIT/STARTX ##

# Auto-run startx on virtual terminal 1, since it's the default VT
# (disabled for now)
#if command_exists startx ; then
#  # for systemd:
#  if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 ]]; then
#    confirm_startx
#  fi
#  # for non-systemd:
#  if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
#    confirm_startx
#  fi
#fi
