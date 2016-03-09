# do not continue if we are not in a bash shell
[ -z "$BASH_VERSION" ] && return
# do not continue if we are not running interactively
[ -z "$PS1" ] && return

# minimal but extremely useful prompt for long scroll histories
PS1='\n\[\e[7m\]\w\[\e[0m\]\n[\u@\h]\$ '

# Remap caps lock to escape to save on pinky strain
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Escape"

# Readline only completes if it matches with the current prefix
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
