" in case the colorscheme isn't applied for some ungodly reason
if !has('gui_running') && !has('nvim') && has('win32')
  augroup config_baddog
    au!
    au VimEnter * exec 'colorscheme baddog' |
          \ exec 'silent! call lightline#enable()'
  augroup END
endif
