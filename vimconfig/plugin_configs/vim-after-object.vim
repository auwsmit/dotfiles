augroup config_after-object
  au!
  au VimEnter * silent! call after_object#enable([']', '['], '=', ':', '-', '#', ' ')
augroup END
