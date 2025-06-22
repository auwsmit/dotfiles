nnoremap <space>r :MRUToggle<cr>
nnoremap <space>R :FZFMru<space>

" other plugins use d, so use x to delete instead
augroup config_mru
  au!
  au FileType mru map <buffer> x dl
augroup END
