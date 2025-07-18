nnoremap <space>gs :G<cr>
nnoremap <space>gd :Gdiffsplit<cr>
nnoremap <space>gD :Gdiffsplit HEAD<cr>
nnoremap <space>gw :Gwrite<cr>
nnoremap <space>gu :G restore --staged %<cr>
nnoremap <space>gc :G commit<cr>
nnoremap <space>gl :G log<cr>
nnoremap <space>gp :G push
nnoremap <space>gg :Ggrep<space>

fun! s:FugitiveMaps()
  nnoremap <buffer> q :<C-U>if bufnr('$') == 1\|quit\|else\|bdelete\|endif<CR>
  if &ft != 'gitcommit'
    nnoremap <buffer> gq q
  endif
  " because of my weird custom :
  nnoremap <buffer> : :
endfun

augroup config_Fugitive
  au!
  au FileType fugitive,git,gitcommit call s:FugitiveMaps()
augroup END
