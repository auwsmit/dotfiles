#!/bin/bash

# run .xprofile
if [ -f ~/.xprofile ] ; then
    ~/.xprofile
fi

# Touchpad:
# enable tap-to-click & "reversed" 2-finger scrolling
synclient TapButton1=1 &
synclient VertScrollDelta=-133 &

# dwm status bar
while true; do
  BATT=$( acpi -b | sed 's/.*[dis|charging|full], \([0-9]*\)%.*/\1/gi' )
  STATUS=$( acpi -b | sed 's/.*: \([a-zA-Z]*\),.*/\1/gi' )
  TIME=$( date +"%I:%M %P" )
  xsetroot -name "$(echo $BATT% $STATUS, $TIME)"
  sleep 5
done &

exec dwm
