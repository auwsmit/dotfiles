if !has('nvim') | finish | endif

lua require("oil").setup()
augroup config_oil
  au!
  " q to quit
  au VimEnter * nnoremap <silent> - :Oil<CR>
  au FileType oil map <buffer> q <C-c>
  au FileType oil nnoremap <buffer> gq q
augroup END
