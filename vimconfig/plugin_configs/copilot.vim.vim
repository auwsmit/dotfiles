" disabled by default
augroup config_copilot
  au!
  au VimEnter * silent! Copilot disable
augroup END

" toggle Copilot suggestions/autocomplete
nnoremap <expr> yoC ':Copilot '.(g:copilot#Enabled() ? 'disable' : 'enable').'<CR>'

" use C-j to enable suggestions for current insert mode
fun! s:CopilotInsertMode()
  if g:copilot#Enabled() | return | endif
  Copilot enable
  augroup config_copilot_insert_map
    au!
    au InsertLeave * exec 'Copilot disable' |
          \ augroup config_copilot_insert_map |
          \ au! | augroup END
  augroup END
endfun
inoremap <C-j> <Esc>:call <SID>CopilotInsertMode()<CR>gi

" " use C-j instead of Tab to accept suggestions
" let g:copilot_no_tab_map = v:true
" imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
