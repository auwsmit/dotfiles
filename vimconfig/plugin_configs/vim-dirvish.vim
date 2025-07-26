" disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" folders on top because Windows Explorer
let g:dirvish_mode = ':sort ,^.*[\/],'

augroup config_dirvish
  au!
  au VimEnter * nnoremap - <Plug>(dirvish_up)
  au VimEnter * highlight link DirvishSuffix Define

  " hide dot-prefixed files, press R to refresh
  au FileType dirvish nnoremap <silent><buffer>
        \ gh m`:keeppatterns %g/[\/\\]\..\+$/d _<CR>
        \ :setl cole=3<CR>:silent! norm! ``<CR>
augroup END
