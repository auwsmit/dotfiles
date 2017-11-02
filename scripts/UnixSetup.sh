#!/bin/bash
# A dotfiles setup script.

# === VARIABLES ==================

# YOUR USERNAME GOES HERE:
username=aws
# (if you don't know, run whoami in the terminal)

# Any of your previous config files will be found here.
#           V  V  V  V  V  V
backup_dir=~/.old_dotfiles
repo_dir=$(cd .. && pwd)

# === FUNCTIONS ==================

# without this, folders would be owned by root
my_mkdir() {
    mkdir -p $1
    chown $username:$username $1
}

# $1 thing to backup,
# $2 path/name of file to link,
# $3 path for backup
make_link_and_backup () {
  # delete previous symbolic link if it exists
  if [ -L $1 ]; then rm $1; fi
  # backup the previous file/folder if it exists
  if [ -e $1 ]; then
      my_mkdir $3
      mv -i $1 $3
  fi
  # make symbolic link
  # for folder
  if [ -d $1 ]; then ln -s -d $2 $1; fi
  # for file
  if [ ! -d $1 ]; then ln -s $2 $1; fi
  chown -h $username:$username $1
}

# === MAIN CODE ==================

# make backup/old config directory
my_mkdir $backup_dir

# vim
make_link_and_backup \
  ~/.vim $repo_dir/vimconfig $backup_dir

# neovim
my_mkdir ~/.config
make_link_and_backup \
  ~/.config/nvim $repo_dir/vimconfig $backup_dir/.config
if [ -L $repo_dir/init.vim ] ; then
  rm $repo_dir/init.vim
fi
if [ ! -e ~/.config/nvim/init.vim ] ; then
  ln -s $repo_dir/vimconfig/vimrc ~/.config/nvim/init.vim
fi

# .bashrc
make_link_and_backup \
  ~/.bashrc $repo_dir/.bashrc $backup_dir

# .bash_profile redirects to .bashrc
make_link_and_backup \
  ~/.bash_profile $repo_dir/.bashrc $backup_dir

# .xinitrc
make_link_and_backup \
  ~/.xinitrc $repo_dir/.xinitrc $backup_dir

# .xprofile
make_link_and_backup \
  ~/.xprofile $repo_dir/.xprofile $backup_dir

# lilyterm
my_mkdir ~/.config/lilyterm
make_link_and_backup \
  ~/.config/lilyterm/default.conf $repo_dir/lilyterm.conf $backup_dir/lilyterm

# .xbindkeysrc
make_link_and_backup \
  ~/.xbindkeysrc $repo_dir/.xbindkeysrc $backup_dir

# check for stray vimrc
if [ -e ~/.vimrc ]; then
  mv -i ~/.vimrc $backup_dir
fi

# Disable pcspkr module (the horrid beeping)
# rmmod -s pcspkr >> /dev/null 2>&1
# echo 'install pcspkr /bin/false' > /etc/modprobe.d/aws_nobeep
