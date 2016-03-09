#!/bin/bash
# A dotfiles setup script. Also not pretty.
# Backups of any potentially replaced files are located at ~/dotfiles_backup

# In this order:
# - Delete previous symbolic links if they exist.
# - Backup the previous config if it exists.
# - Make symbolic links.
mkdir ~/dotfiles_backup
if [ -L ~/.vim ] ; then
  rm ~/.vim
fi
if [ -e ~/.vim ] ; then
  mv -i ~/.vim ~/dotfiles_backup
fi
ln -s -d $(pwd)/vimconfig ~/.vim

# nvim
if [ -e ~/.config ] ; then
  mv -i ~/.config ~/dotfiles_backup
fi
mkdir ~/.config
if [ -L ~/.config/nvim ] ; then
  rm ~/.config/nvim
fi
ln -s -d $(pwd)/vimconfig ~/.config/nvim
if [ -L $(pwd)/init.vim ] ; then
  rm $(pwd)/init.vim
fi
ln -s ~/.config/nvim/init.vim $(pwd)/vimconfig/vimrc

if [ -L ~/.bashrc ] ; then
  rm ~/.bashrc
fi
if [ -e ~/.bashrc ] ; then
  mv -i ~/.bashrc ~/dotfiles_backup
fi
ln -s $(pwd)/.bashrc ~/.bashrc

if [ -L ~/.bash_profile ] ; then
  rm ~/.bash_profile
fi
if [ -e ~/.bash_profile ] ; then
  mv -i ~/.bash_profile ~/dotfiles_backup
fi
ln -s $(pwd)/.bash_profile ~/.bash_profile

if [ -L ~/.profile ] ; then
  rm ~/.profile
fi
if [ -e ~/.profile ] ; then
  mv -i ~/.profile ~/dotfiles_backup
fi
ln -s $(pwd)/.profile ~/.profile

# check for stray vimrc
if [ -e ~/.vimrc ] ; then
  mv -i ~/.vimrc ~/dotfiles_backup
fi

# custom configs like remapping Caps Lock to Escape
source ~/.bashrc
