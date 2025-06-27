let g:fzf_command_prefix = 'Fzf'

nnoremap <space>- :FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>
nnoremap <space>+ :FZF<cr>
nnoremap <space>b :FzfBuffers<cr>
nnoremap <space>fr :FzfHistory<cr>
nnoremap <space>ff :FZF<space>
nnoremap <space>fl :FzfLines<cr>
nnoremap <space>fb :FzfBLines<cr>
nnoremap <space>ft :FzfTags<cr>
nnoremap <space>f: :FzfHistory:<cr>
nnoremap <space>f/ :FzfHistory/<cr>
nnoremap <space>fg :FzfGFiles<cr>
nnoremap <space>fs :FzfGFiles?<cr>
nnoremap <space><space> :FzfCommands<cr>

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
