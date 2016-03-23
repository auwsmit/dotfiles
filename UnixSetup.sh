#!/bin/bash
# A dotfiles setup script. Also not pretty.
# Backups of any potentially replaced files are located at ~/dotfiles_backup

# In this order:
# - Delete previous symbolic links if they exist.
# - Backup the previous config if it exists.
# - Make symbolic links.
# TODO: make this^ into a function

mkdir -p ~/dotfiles_backup

# vim
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
mkdir -p ~/.config
if [ -L ~/.config/nvim ] ; then
  rm ~/.config/nvim
fi
ln -s -d $(pwd)/vimconfig ~/.config/nvim
if [ -L $(pwd)/init.vim ] ; then
  rm $(pwd)/init.vim
fi
if [ ! -e ~/.config/nvim/init.vim ] ; then
  ln -s $(pwd)/vimconfig/vimrc ~/.config/nvim/init.vim
fi

# .bashrc
if [ -L ~/.bashrc ] ; then
  rm ~/.bashrc
fi
if [ -e ~/.bashrc ] ; then
  mv -i ~/.bashrc ~/dotfiles_backup
fi
ln -s $(pwd)/.bashrc ~/.bashrc

# .bash_profile redirects to .bashrc
if [ -L ~/.bash_profile ] ; then
  rm ~/.bash_profile
fi
if [ -e ~/.bash_profile ] ; then
  mv -i ~/.bash_profile ~/dotfiles_backup
fi
ln -s $(pwd)/.bashrc ~/.bash_profile

# .profile redirects to .bashrc
if [ -L ~/.profile ] ; then
  rm ~/.profile
fi
if [ -e ~/.profile ] ; then
  mv -i ~/.profile ~/dotfiles_backup
fi
ln -s $(pwd)/.bashrc ~/.profile

# .CapsToEscape
if [ -L ~/.CapsToEscape ] ; then
  rm ~/.CapsToEscape
fi
if [ -e ~/.CapsToEscape ] ; then
  mv -i ~/.CapsToEscape ~/dotfiles_backup
fi
ln -s $(pwd)/.CapsToEscape ~/.CapsToEscape

# check for stray vimrc
if [ -e ~/.vimrc ] ; then
  mv -i ~/.vimrc ~/dotfiles_backup
fi

# Remap Caps to Escape
xmodmap ~/.CapsToEscape 2> /dev/null
