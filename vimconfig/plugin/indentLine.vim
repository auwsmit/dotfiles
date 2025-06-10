nnoremap <space>I :IndentLinesToggle<cr>
" use custom filetype detection for better vim-plug compatibility
let g:indentLine_enabled = 0
let g:indentLine_fileType = ['']
au FileType c,cpp IndentLinesEnable
