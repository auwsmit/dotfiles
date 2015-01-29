#!/bin/bash
## Makes a symbolic link to this vimrc in your home directory
## Puts any old vimrcs in a folder "vimrc_backup"

## delete previous symbolic link if it exists
if [ -L ~/.vimrc ] ; then
  rm ~/.vimrc
fi

## backup the previous vimrc if it exists
if [ -e ~/.vimrc ] ; then
  mkdir ~/vimrc_backup
  mv ~/.vimrc ~/vimrc_backup
fi

ln -s $(pwd)/.vimrc ~/.vimrc
