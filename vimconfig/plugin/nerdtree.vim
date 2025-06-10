nnoremap <space>n :NERDTreeFind<cr>
" close if nerdtree is last window
au BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1
      \ && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
