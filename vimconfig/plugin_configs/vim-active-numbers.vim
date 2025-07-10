" disable auto updating settings for harpoon
" TODO: ???
let g:actnum_autoupdate = 0

" tpope's unimpaired style bindings

" " disabled for now
" fun s:toggle()
"   if !&nu && !&rnu
"     SetActiveNumbers nu rnu
"   else
"     SetActiveNumbers nonu nornu
" endfun

let g:actnum_exclude =
      \ [ 'unite', 'tagbar', 'startify', 'undotree', 'gundo', 'vimshell', 'w3m', 'copilot_chat' ]
fun! s:ActiveNumberUnimpaired()
  nnoremap <silent> yoa :ActiveNumbers<CR>
  nnoremap <silent> yon :SetActiveNumbers number!<CR>
  nnoremap <silent> yor :SetActiveNumbers relativenumber!<CR>
  " nnoremap <silent> [on :SetActiveNumbers number<CR>
  " nnoremap <silent> ]on :SetActiveNumbers nonumber<CR>
  " nnoremap <silent> [or :SetActiveNumbers relativenumber<CR>
  " nnoremap <silent> ]or :SetActiveNumbers norelativenumber<CR>
endfun

augroup config_active_numbers
  au!
  au VimEnter * call <sid>ActiveNumberUnimpaired()
augroup END
