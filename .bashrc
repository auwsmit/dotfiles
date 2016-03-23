# do not continue if we are not in a bash shell
[ -z "$BASH_VERSION" ] && return

# do not continue if we are not running interactively
[ -z "$PS1" ] && return

# minimal but extremely useful prompt for long scroll histories
PS1='\n\[\e[7m\]\w\[\e[0m\]\n[\u@\h]\$ '

# Readline only completes if it matches with the current prefix
bind '"\e[A"':history-search-backward 2> /dev/null
bind '"\e[B"':history-search-forward 2> /dev/null

# Remap caps lock to escape.
# Some day I'll figure out how to run this consistently at startup without running the terminal
xmodmap .CapsToEscape 2> /dev/null
