nnoremap <space>I :IndentLinesToggle<cr>

" use custom filetype detection for better vim-plug compatibility
let g:indentLine_enabled = 0
let g:indentLine_fileType = ['']

augroup config_indentLine
  au!
  au FileType c,cpp IndentLinesEnable
augroup END
