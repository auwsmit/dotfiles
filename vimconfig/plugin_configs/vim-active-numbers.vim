" disable auto updating settings for harpoon
let g:actnum_autoupdate = 0

" tpope's unimpaired also updates active numbers
fun! s:ActiveNumberUnimpaired()
  nnoremap yon :SetActiveNumbers number!<cr>
  nnoremap [on :SetActiveNumbers number<cr>
  nnoremap ]on :SetActiveNumbers nonumber<cr>
  nnoremap yor :SetActiveNumbers relativenumber!<cr>
  nnoremap [or :SetActiveNumbers relativenumber<cr>
  nnoremap ]or :SetActiveNumbers norelativenumber<cr>
endfun

augroup active_number_config
  au!
  au VimEnter * call <sid>ActiveNumberUnimpaired()
augroup END
