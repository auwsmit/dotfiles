" surround-like mappings
let g:sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1

augroup config_sandwich
  au!
  au VimEnter * runtime macros/sandwich/keymap/surround.vim
augroup END
