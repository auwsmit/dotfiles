" DWIW Open old or new Copilot Chat
fun! s:OpenCopilotChat()
  if bufname('%') =~ '^CopilotChat-\d\+'
    close
  else
    let wn = winnr()
    silent! CopilotChatFocus
    if wn == winnr() | exec 'silent! CopilotChatOpen' | endif
  endif
endfun

nnoremap <silent> <Space>* :call <SID>OpenCopilotChat()<CR>
