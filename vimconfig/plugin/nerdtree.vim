nnoremap <space>n :NERDTreeFind<cr>
" close if nerdtree is last window
augroup config_NERDTree
  au!
  au BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1
      \ && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END
