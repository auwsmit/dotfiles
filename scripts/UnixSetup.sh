#!/bin/bash
# A dotfiles setup script.

# === VARIABLES ===

# YOUR USERNAME GOES HERE:
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

# like a decade out of date, will probably delete
# # .bash_profile redirects to .bashrc
# make_link_and_backup \
#   ~/.bash_profile $repo_dir/.bashrc $backup_dir
# .bash_profile redirects to .bashrc

# make_link_and_backup \
#   ~/.bash_profile $repo_dir/.bashrc $backup_dir

# # .xinitrc
# make_link_and_backup \
#   ~/.xinitrc $repo_dir/.xinitrc $backup_dir

# # .xprofile
# make_link_and_backup \
#   ~/.xprofile $repo_dir/.xprofile $backup_dir

# # lilyterm
# my_mkdir ~/.config/lilyterm
# make_link_and_backup \
#   ~/.config/lilyterm/default.conf $repo_dir/lilyterm.conf $backup_dir/lilyterm

# # .xbindkeysrc
# make_link_and_backup \
#   ~/.xbindkeysrc $repo_dir/.xbindkeysrc $backup_dir
