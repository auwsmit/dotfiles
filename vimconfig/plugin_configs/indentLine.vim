nnoremap <space>I :IndentLinesToggle<cr>

" use custom filetype detection for better vim-plug compatibility
let g:indentLine_enabled = 0
let g:indentLine_fileType = ['']

augroup config_indentLine
  au!
  au FileType c,cpp IndentLinesEnable

  " workaround to fix weird bug where indent lines are incorrectly colored for
  " the initial file until the buffer is reloaded.
  "
  " it's probably caused by some conflict with some other part of my config,
  " but I'm too lazy to figure out the root of the problem, and this works fine
  au VimEnter * exec filereadable(expand('%')) ? 'edit | IndentLinesEnable' : ''
augroup END
