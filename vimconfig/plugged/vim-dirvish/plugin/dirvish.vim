if exists('g:loaded_dirvish') || &cp || version < 700 || &cpo =~# 'C'
  finish
endif
let g:loaded_dirvish = 1

command! -bar -nargs=? -complete=dir Dirvish call dirvish#open(<q-args>)

function! s:isdir(dir)
  return !empty(a:dir) && (isdirectory(a:dir) ||
    \ (!empty($SYSTEMDRIVE) && isdirectory('/'.tolower($SYSTEMDRIVE[0]).a:dir)))
endfunction

if get(g:, 'dirvish_hijack_netrw', 1)
  augroup dirvish_netrw
    autocmd!
    " nuke netrw brain damage
    autocmd VimEnter * silent! au! FileExplorer *
    autocmd BufEnter * if !exists('b:dirvish') && <SID>isdir(expand('%'))
      \ | redraw | echo ''
      \ | exe 'Dirvish %' | endif
  augroup END
endif

highlight! link DirvishPathTail Directory
