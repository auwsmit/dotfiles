#!/bin/bash
# A dotfiles setup script. Also not pretty.
# Backups of any potentially replaced files are located at ~/dotfiles_backup

# In this order:
# - Delete previous symbolic links if they exist.
# - Backup the previous config if it exists.
# - Make symbolic links.
# TODO: make this^ into a function

repo_dir=$(cd .. && pwd)
backup_dir=~/.dotfiles_backup

mkdir -p $backup_dir

# vim
if [ -L ~/.vim ] ; then
  rm ~/.vim
fi
if [ -e ~/.vim ] ; then
  mv -i ~/.vim $backup_dir
fi
ln -s -d $repo_dir/vimconfig ~/.vim

# nvim
mkdir -p ~/.config
if [ -L ~/.config/nvim ] ; then
  rm ~/.config/nvim
fi
if [ -e ~/.config/nvim ] ; then
  mkdir -p $backup_dir/.config
  mv -i ~/.config/nvim $backup_dir
fi
ln -s -d $repo_dir/vimconfig ~/.config/nvim
if [ -L $repo_dir/init.vim ] ; then
  rm $repo_dir/init.vim
fi
if [ ! -e ~/.config/nvim/init.vim ] ; then
  ln -s $repo_dir/vimconfig/vimrc ~/.config/nvim/init.vim
fi

# .bashrc
if [ -L ~/.bashrc ] ; then
  rm ~/.bashrc
fi
if [ -e ~/.bashrc ] ; then
  mv -i ~/.bashrc $backup_dir
fi
ln -s $repo_dir/.bashrc ~/.bashrc

# .bash_profile redirects to .bashrc
if [ -L ~/.bash_profile ] ; then
  rm ~/.bash_profile
fi
if [ -e ~/.bash_profile ] ; then
  mv -i ~/.bash_profile $backup_dir
fi
ln -s $repo_dir/.bashrc ~/.bash_profile

# check for stray vimrc
if [ -e ~/.vimrc ] ; then
  mv -i ~/.vimrc $backup_dir
fi

# Disable pcspkr module (the horrid beeping)
rmmod -s pcspkr >> /dev/null 2>&1
echo 'install pcspkr /bin/false' > /etc/modprobe.d/aws_nobeep
