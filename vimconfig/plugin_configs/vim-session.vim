let g:session_autosave = 0
let g:session_autoload = 0
augroup config_sessions
  au!
  au VimEnter * silent! exec 'au! PluginXoloxMisc'
augroup END
