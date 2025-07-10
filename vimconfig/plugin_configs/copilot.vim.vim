let g:copilot_no_tab_map = v:true

" use C-j instead of Tab to accept suggestions
imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")

" toggle Copilot
nnoremap <expr> yoC ':Copilot '.(g:copilot#Enabled() ? 'disable' : 'enable').'<CR>'
