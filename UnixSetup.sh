#!/bin/bash
## Makes a symbolic link to this vimrc in your home directory
## Puts any old vimrcs in a folder "dotfiles_backup"

## delete previous symbolic links if they exist
if [ -L ~/.vim ] ; then
  rm ~/.vim
fi
if [ -L ~/.xinitrc ] ; then
  rm ~/.xinitrc
fi

## backup the previous config if it exists
if [ -e ~/.vim ] ; then
  mkdir ~/dotfiles_backup
  mv ~/.vim ~/dotfiles_backup
  if [ -e ~/.xinitrc ] ; then
    mv ~/.xinitrc ~/dotfiles_backup
  fi
fi

ln -s -d $(pwd)/vimconfig ~/.vim
ln -s -d $(pwd)/.xinitrc ~/.xinitrc

## runs a script to remap CapsLock to Escape
source ~/.xinitrc
