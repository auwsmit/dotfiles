#!/bin/bash
# A dotfiles setup script.

# Any of your previous config
# files should be found here.
#  (if you run the script)
#           V  V  V  V  V  V
backup_dir=~/.dotfiles_backup
repo_dir=$(cd .. && pwd)
mkdir -p $backup_dir

# $1 thing to backup,
# $2 path/name of file to link,
# $3 path for backup
make_link_and_backup () {
  # delete previous symbolic link if it exists
  if [ -L $1 ]; then rm $1; fi
  # backup the previous file/folder if it exists
  if [ -e $1 ]; then mv -i $1 $3; fi
  # make symbolic link
  # for folder
  if [ -d $1 ]; then ln -s -d $2 $1; fi
  # for file
  if [ ! -d $1 ]; then ln -s $2 $1; fi
}

# vim
make_link_and_backup \
  ~/.vim $repo_dir/vimconfig $backup_dir

# .bashrc
make_link_and_backup \
  ~/.bashrc $repo_dir/.bashrc $backup_dir

# .bash_profile redirects to .bashrc
make_link_and_backup \
  ~/.bash_profile $repo_dir/.bash_profile $backup_dir

# neovim
mkdir -p ~/.config
if [ -e ~/.config/nvim ]; then
  mkdir -p $backup_dir/.config
fi
make_link_and_backup \
  ~/.config/nvim $repo_dir/vimconfig $backup_dir/.config
make_link_and_backup \
  $repo_dir/init.vim ~/.config/nvim/init.vim $backup_dir

# check for stray vimrc
if [ -e ~/.vimrc ]; then
  mv -i ~/.vimrc $backup_dir
fi

# Disable pcspkr module (the horrid beeping)
rmmod -s pcspkr >> /dev/null 2>&1
echo 'install pcspkr /bin/false' > /etc/modprobe.d/aws_nobeep
