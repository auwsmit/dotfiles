let g:copilot_no_tab_map = v:true

" use C-j instead of Tab to accept suggestions
imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")

" toggle Copilot suggestions/autocomplete
nnoremap <expr> yoC ':Copilot '.(g:copilot#Enabled() ? 'disable' : 'enable').'<CR>'

" " disabled by default
" augroup config_copilot
"   au!
"   au VimEnter * Copilot disable
" augroup END
