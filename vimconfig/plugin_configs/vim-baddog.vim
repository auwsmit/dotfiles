" in case the colorscheme isn't applied for some ungodly reason
augroup config_baddog
  au!
  au VimEnter * exec 'colorscheme baddog' |
        \ exec 'silent! call lightline#enable()'
augroup END
