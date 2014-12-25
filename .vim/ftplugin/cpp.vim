" make C++ configured the same as C
if has('win32')
  " God damn it Windows, no one likes backslashes
  source $VIM\vimfiles\ftplugin\c.vim
else
  source ~/.vim/ftplugin/c.vim
endif
