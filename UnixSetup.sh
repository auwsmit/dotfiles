#!/bin/bash
# Makes a symbolic link to this vimrc in your home directory
# Puts any old vimrcs in a folder "dotfiles_backup"

# delete previous symbolic links if they exist
if [ -L ~/.vim ] ; then
  rm ~/.vim
fi
if [ -L ~/.bashrc ] ; then
  rm ~/.bashrc
fi
if [ -L ~/.bash_profile ] ; then
  rm ~/.bash_profile
fi
if [ -L ~/.profile ] ; then
  rm ~/.profile
fi

# backup the previous config if it exists
if [ -e ~/.vim ] ; then
  mkdir ~/dotfiles_backup
  mv ~/.vim ~/dotfiles_backup
  if [ -e ~/.bashrc ] ; then
    mv ~/.bashrc ~/dotfiles_backup
  fi
  if [ -e ~/.bash_profile ] ; then
    mv ~/.bash_profile ~/dotfiles_backup
  fi
  if [ -e ~/.profile ] ; then
    mv ~/.profile ~/dotfiles_backup
  fi
fi

# symbolic links
ln -s -d $(pwd)/vimconfig ~/.vim
ln -s -d $(pwd)/.bashrc ~/.bashrc
ln -s -d $(pwd)/.bash_profile ~/.bash_profile
ln -s -d $(pwd)/.profile ~/.profile

# custom configs like remapping Caps Lock to Escape
source ~/.bashrc
