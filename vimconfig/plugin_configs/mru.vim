let MRU_Max_Entries = 1000
let MRU_Convert_Slashes = 1

nnoremap <space>r :MRUToggle<cr>
nnoremap <space>fr :FZFMru<cr>

augroup config_mru
  au!
" other plugins use d, so use x to delete instead
  au FileType mru map <buffer> x dlh

  " convenience and consistency with other plugins like FZF
  au FileType mru noremap <buffer> <C-j> j
  au FileType mru noremap <buffer> <C-k> k
augroup END
