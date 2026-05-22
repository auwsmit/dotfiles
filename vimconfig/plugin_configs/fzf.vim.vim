nnoremap <Space>F  :FZF <C-r>=fnameescape(expand('%:p:h'))<CR>
nnoremap <Space>-  :FZF <C-r>=fnameescape(expand('%:p:h'))<CR>/<CR>
nnoremap <Space>+  :FZF<CR>
nnoremap <Space>b  :Buffers<CR>
nnoremap <Space>fl :BLines<CR>
nnoremap <Space>fL :Lines<CR>
nnoremap <Space>f: :History:<CR>
nnoremap <Space>f/ :History/<CR>
nnoremap <Space>fg :GFiles<CR>
nnoremap <Space>: :Commands<CR>

" adapt to colorscheme
let g:fzf_colors =
      \ { 'fg':    ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
