nnoremap <space>R :MRUToggle<cr>
nnoremap <space>r :FZFMru<cr>

" other plugins use d, so use x to delete instead
augroup config_mru
  au!
  au FileType mru map <buffer> x dlh
augroup END
