" surround-like mappings
let g:sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1

" format within new bracket block
" useful for C programming
xnoremap S{ <Esc>`<O{<Esc>`>o}<Esc>gv=

augroup config_sandwich
  au!
  au VimEnter * runtime macros/sandwich/keymap/surround.vim
augroup END
