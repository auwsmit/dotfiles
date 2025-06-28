#!/bin/bash
# A dotfiles setup script.

# === VARIABLES ===

read -p "Enter username: " username

home=/home/$username
# Any of previous config files will be found here.
#           V  V  V  V  V  V
backup_dir=$home/.old_dotfiles
repo_dir=$(cd .. && pwd)

# === FUNCTIONS ===

# without this, folders would be owned by root
my_mkdir() {
  mkdir -p $1
  chown $username:$username $1
}

# $1 target of the link
# $2 thing to link and backup,
# $3 path for backup
make_link_and_backup () {
  # delete previous symbolic link if it exists
  if [ -L $2 ]; then rm $2; fi
  # backup the previous file/folder if it exists
  if [ -e $2 ]; then
    my_mkdir $3
    mv -i $2 $3
  fi
  # make symbolic link
  # for folder
  if [ -d $1 ]; then
    ln -s -d $1 $2
  fi
  # for file
  if [ ! -d $1 ]; then
    ln -s $1 $2
  fi
  chown -h $username:$username $2
}

# === MAIN CODE ===

# make backup directory for already existing files
my_mkdir $backup_dir

# vim
make_link_and_backup $repo_dir/vimconfig $home/.vim $backup_dir
# check for stray vimrc
if [ -e $home/.vimrc ]; then
  mv -i $home/.vimrc $backup_dir
fi

# neovim
my_mkdir $home/.config
my_mkdir $home/.local/share
make_link_and_backup $repo_dir/vimconfig $home/.config/nvim      $backup_dir/.config
make_link_and_backup $repo_dir/vimconfig $home/.local/share/nvim $backup_dir/.local/share
# since we're already making a link for .config/nvim,
# just make a fake init.vim in the repo
if [ -L $repo_dir/init.vim ] ; then
  rm $repo_dir/init.vim
fi
if [ ! -e $home/.config/nvim/init.vim ] ; then
  ln -s $repo_dir/vimconfig/vimrc $repo_dir/vimconfig/init.vim
fi

# .bashrc
make_link_and_backup $repo_dir/.bashrc $home/.bashrc $backup_dir
# .inputrc
make_link_and_backup $repo_dir/.inputrc $home/.inputrc $backup_dir
