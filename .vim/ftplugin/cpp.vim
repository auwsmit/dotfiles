" make C++ configured the same as C
if has('win32')
  " God damn it Windows, no one likes backslashes
  source $HOME\vimfiles\ftplugin\c.vim
else
  source ~/.vim/ftplugin/c.vim
endif
