#!/bin/bash
# A dotfiles setup script.

# === VARIABLES ===

username="$(whoami)"
if [ $username == "root" ]; then
  read -p "Enter username: " username
  home=/home/$username
else
  home=~
fi

# Any previous config files will be found here.
#           V  V  V  V  V  V
backup_dir=$home/.old_dotfiles
script_dir="$(dirname "$(realpath "$0")")"
repo_dir=$script_dir/..

# === FUNCTIONS ===

# only needed if script is ran as root
my_mkdir() {
  mkdir -p $1
  chown $username:$username $1
}

# $1 target of the link
# $2 file to link and backup,
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

# check if home directory is valid
if [ ! -e $home ]; then
  echo "Invalid home directory. Edit the script and run again."
  exit 1
fi

# make backup directory for already existing files
if [ -e $backup_dir ]; then
  # backup any previously existing old_dotfiles
  mv $backup_dir $home/.older_dotfiles
  my_mkdir $backup_dir
  mv $home/.older_dotfiles $backup_dir
else
  my_mkdir $backup_dir
fi

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
if [ ! -e $home/.config/nvim/init.vim ] ; then
  ln -s $repo_dir/vimconfig/vimrc $repo_dir/vimconfig/init.vim
fi

# .bashrc
make_link_and_backup $repo_dir/.bashrc $home/.bashrc $backup_dir
# .inputrc
make_link_and_backup $repo_dir/.inputrc $home/.inputrc $backup_dir

# if backup folder is empty, delete it
if [ -z "$(ls -A $backup_dir)" ]; then
  rmdir $backup_dir
fi
