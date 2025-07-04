" disable auto updating settings for harpoon
let g:actnum_autoupdate = 0

" tpope's unimpaired style bindings
fun s:toggle()
  if &nonu && &nornu
    SetActiveNumbers nu rnu
  else
    SetActiveNumbers nonu nornu
endfun
fun! s:ActiveNumberUnimpaired()
  nnoremap <silent> yoa :call <SID>toggle()<CR>
  nnoremap <silent> yon :SetActiveNumbers number!<CR>
  nnoremap <silent> yor :SetActiveNumbers relativenumber!<CR>
  " nnoremap <silent> [on :SetActiveNumbers number<CR>
  " nnoremap <silent> ]on :SetActiveNumbers nonumber<CR>
  " nnoremap <silent> [or :SetActiveNumbers relativenumber<CR>
  " nnoremap <silent> ]or :SetActiveNumbers norelativenumber<CR>
endfun

augroup active_number_config
  au!
  au VimEnter * call <sid>ActiveNumberUnimpaired()
augroup END
