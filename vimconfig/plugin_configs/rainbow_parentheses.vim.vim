if has('nvim') | finish | endif

augroup config_RainbowParens
  au!

  " fix for weird oil.nvim help file bug
  au FileType help setlocal nomodeline

  au FileType c,cpp,vim,sh,dosbatch,lisp silent! RainbowParentheses
augroup END
