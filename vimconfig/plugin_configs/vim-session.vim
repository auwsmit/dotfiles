let g:session_autosave = 0
let g:session_autoload = 0
let g:session_persist_colors = 0

nnoremap <Space>SS :SaveSession<Space>
nnoremap <Space>SO :OpenSession<Space>

augroup config_sessions
  au!
  " au VimEnter * silent! exec 'au! PluginXoloxMisc'
augroup END
