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

backup_orig () {
  if [ -e $1 ]; then
    my_mkdir $backup_dir/$2
    mv -i $1 $backup_dir/$2
  fi
}

# create/update symbolic link
make_link () {
  if [ -L $2 ]; then
    rm $2
  fi
  if [ -d $1 ]; then
    ln -s -d $1 $2
  fi
  if [ ! -d $1 ]; then
    ln -s $1 $2
  fi
}

# $1 target of the link
# $2 file to link and backup,
# $3 sub-path for backup folder (optional)
backup_and_link () {
  if [ ! -L $2 ]; then
    backup_orig $2 $3
  fi
  make_link $1 $2
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

# primary dotfiles
backup_and_link $repo_dir/.bashrc    $home/.bashrc
backup_and_link $repo_dir/.inputrc   $home/.inputrc
backup_and_link $repo_dir/.tmux.conf $home/.tmux.conf
backup_orig $home/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# vim
backup_and_link $repo_dir/vimconfig $home/.vim
# check for stray vimrc
backup_orig $home/.vimrc

# neovim
my_mkdir $home/.config
my_mkdir $home/.local/share
backup_and_link $repo_dir/vimconfig       $home/.config/nvim           .config
backup_and_link $repo_dir/vimconfig       $home/.local/share/nvim      .local/share
make_link       $repo_dir/vimconfig/vimrc $repo_dir/vimconfig/init.vim

# git completion for aliases
make_link $repo_dir/git-completion.bash $home/git-completion.bash

# if backup folder is empty, delete it
if [ -z "$(ls -A $backup_dir)" ]; then
  rmdir $backup_dir
fi

# prompt installing vim plugins
while true; do
  read -p "Install vim plugins? [y/n]: " yn
  case $yn in
    [Yy]* )
      if command -v "nvim" &>/dev/null; then
        nvim -c "PlugInstall | quitall"
      else
        vim -c "PlugInstall | quitall"
      fi
      break;;
    [Nn]* ) exit;;
    * ) ;;
  esac
done
