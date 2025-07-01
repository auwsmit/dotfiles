if has('nvim') | finish | endif

" disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

augroup config_dirvish
  au!
  au VimEnter * nnoremap - <Plug>(dirvish_up)

  " hide dotfiles
  au FileType dirvish nnoremap <buffer> gh
        \ :g@\v/\.[^\/]+/?$@d<cr>
augroup END
