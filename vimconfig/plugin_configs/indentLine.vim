nnoremap <space>I :IndentLinesToggle<cr>

let g:indentLine_enabled = 1
let g:indentLine_setColors = 0
let g:indentLine_char = '┊'

fun! s:IndentLinesMatch()
  hi clear Conceal
  hi clear NonText
  hi link Conceal Comment
  hi link NonText Comment
endfun

" for testing colorschemes that have bright conceal highlights
command! IndentLinesMatch call <SID>IndentLinesMatch()
