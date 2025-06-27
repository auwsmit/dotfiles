" disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

augroup config_dirvish
  au!
  " gh to hide "hidden" files. (Unix only)
  " au VimEnter * nnoremap - <Plug>(dirvish_up)
  au FileType dirvish nnoremap <buffer> gh
        \ :g@\v/\.[^\/]+/?$@d<cr>
  " - to keep going up the directory tree
  au FileType dirvish nnoremap <buffer> -
        \ :e <C-R>=fnameescape(expand('%:p:h'))<CR>/..<CR>
augroup END
