" lighter folds
let g:baddoggo_folded = 2

" in case the colorscheme isn't applied for some ungodly reason
augroup baddoggo_config
  au!
  au VimEnter * exec 'colorscheme baddoggo' |
        \ exec 'silent! call lightline#enable()'
augroup END
