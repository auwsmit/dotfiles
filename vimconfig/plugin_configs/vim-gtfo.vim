" vim-gtfo overrides
if has('win32')
  nnoremap got :exec 'silent !start powershell -NoExit -Command "cd '.escape(expand('%:p:h'),' !').'"'<CR>
  if executable('FPilot')
    nnoremap gof :exec 'silent !start FPilot '.escape(expand('%:p'),' !')<CR>
  endif
endif
