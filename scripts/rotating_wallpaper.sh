#!/bin/bash
# display wallpapers in random order

# time between wallpaper's changing
BG_DELAY=60m
# directory containing wallpapers
BG_DIR=~/Pictures/Wallpapers

cd $BG_DIR
# random order:
papes=$(ls . | shuf)

while true; do
    for f in $papes
    do
        feh --bg-fill $f
        sleep $BG_DELAY
    done
done
