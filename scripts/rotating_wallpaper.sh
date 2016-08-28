#!/bin/bash

papes=~/Pictures/Wallpapers/*
while true; do
    for f in $papes
    do
        feh --bg-fill $f
        sleep 60m
    done
done
