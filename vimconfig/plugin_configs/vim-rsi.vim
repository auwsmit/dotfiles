augroup config_rsi
  au!
  " lemme use cmdwin if I'm not at EOL
  au VimEnter * cunmap <C-f>

  " lemme un-indent in insert mode
  au VimEnter * iunmap <C-d>
augroup END
