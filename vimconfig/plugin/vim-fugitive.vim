nnoremap <space>gs :G<cr>
nnoremap <space>gd :Gdiffsplit<cr>
nnoremap <space>gD :Gdiffsplit HEAD<cr>
nnoremap <space>gc :G commit<cr>
nnoremap <space>gl :G log<cr>
nnoremap <space>gp :G push<cr>
nnoremap <space>gw :Gwrite<cr>
nnoremap <space>gg :Ggrep<space>

augroup config_Fugitive
  au!
  " hide fugitive buffers to reduce buffer list clutter
  au BufReadPost fugitive://* set bufhidden=delete
augroup END
