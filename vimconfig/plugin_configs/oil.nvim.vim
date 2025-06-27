lua require("oil").setup()
augroup config_oil
  au!
  " q to quit
  au VimEnter * lua vim.keymap.set(
        \ "n", "-", "<CMD>Oil<CR>",
        \ { desc = "Open parent directory" })
  au FileType oil map <buffer> q <C-c>
  au FileType oil nnoremap <buffer> gq q
augroup END
