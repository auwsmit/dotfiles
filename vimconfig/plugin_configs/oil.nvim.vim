if !has('nvim') | finish | endif

lua << ENDLUA
require("oil").setup({
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true
  }
})
ENDLUA

augroup config_oil
  au!
  " q to quit
  au VimEnter * nnoremap <silent> - :Oil<CR>
  au FileType oil map <buffer> q <C-c>
  au FileType oil nnoremap <buffer> gq q
augroup END
