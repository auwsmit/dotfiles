fun! s:ToggleCopilotChat()
  if bufname('%') =~ '^CopilotChat-\d\+'
    close
  else
    let wn = winnr()
    silent! CopilotChatFocus
    if wn == winnr() | exec 'silent! CopilotChatOpen' | endif
  endif
endfun

nnoremap <silent> <Space>* :call <SID>ToggleCopilotChat()<CR>
