# do not continue if we are not in a bash shell
[ -z "$BASH_VERSION" ] && return

# do not continue if we are not running interactively
[ -z "$PS1" ] && return

# minimal prompt:
#   current directory name and shell level (when > 1)
PS1=' \W $(((SHLVL>1)) && echo "["$SHLVL"] ")$\[\e[0m\] '

# Readline only completes if it matches with the current prefix
bind '"\e[A"':history-search-backward 2> /dev/null
bind '"\e[B"':history-search-forward 2> /dev/null

# Remap caps lock to control.
# Some day I'll figure out how to run this consistently at startup without running the terminal
xmodmap -e 'keycode 66 = Control_L' 2> /dev/null
xmodmap -e 'clear Lock' 2> /dev/null
xmodmap -e 'add Control = Control_L' 2> /dev/null
