" let g:baddog_treesitter_config = 1

augroup config_baddog
  au!
  if !has('gui_running') && !has('nvim') && has('win32')
    " in case the colorscheme isn't applied for some ungodly reason
    au VimEnter * exec 'colorscheme baddog' |
          \ exec 'silent! call lightline#enable()'
  endif

  au Colorscheme * if g:colors_name=='baddog' && g:loaded_lightline
        \ |          call lightline#enable()
        \ |          syntax on
        \ |        else
        \ |          call lightline#disable()
augroup END
