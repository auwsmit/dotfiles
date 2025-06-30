let g:fzf_command_prefix = 'Fzf'

nnoremap <Space>F :FZF <C-r>=fnameescape(expand('%:p:h'))<CR>
nnoremap <Space>- :FZF <C-r>=fnameescape(expand('%:p:h'))<CR>/<CR>
nnoremap <Space>b :FzfBuffers<CR>
nnoremap <Space>fl :FzfLines<CR>
nnoremap <Space>fb :FzfBLines<CR>
nnoremap <Space>f: :FzfHistory:<CR>
nnoremap <Space>f/ :FzfHistory/<CR>
nnoremap <Space>fg :FzfGFiles<CR>
nnoremap <Space>fs :FzfGFiles?<CR>
nnoremap <Space>ff :FZF<Space>
nnoremap <Space><Space> :FzfCommands<CR>

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
