augroup config_after_object
  au!
  au VimEnter * silent! call after_object#enable('=', ':')
augroup END
