" defaults
let g:spear_delete_blank_lines = 0
let g:spear_delete_invalid_files = 0
let g:spear_quit_on_save = 1
let g:spear_save_on_change = 0
let g:spear_next_prev_cycle = 0
let g:spear_convert_backslashes = 0
let g:spear_use_floating_window = 1

fun! s:SpearMaps()
  nnoremap <silent> <C-s>     :call spear#toggle_menu()<CR>
  nnoremap <silent> <Space>A  :call spear#add_file()<CR>
  nnoremap <silent> <Space>X  :call spear#remove_file()<CR>
  for i in range(1, 9)
    exec 'nnoremap <silent> <Space>'.i.' :call spear#open_file('.i.')<CR>'
  endfor
  nnoremap <silent> <C-Right> :call spear#next_prev_file('next')<CR>
  nnoremap <silent> <C-Left>  :call spear#next_prev_file('prev')<CR>
endfun
call s:SpearMaps()

augroup config_spear
  au!
  au VimEnter * call s:SpearMaps()
augroup END

" let g:spear_create_commands = 1
" nnoremap <silent> <space>A :SpearAdd<cr>
" nnoremap <silent> <space>X :SpearRemove<cr>
" nnoremap <silent> <C-s>    :SpearToggle<cr>
" nnoremap <silent> <C-h>    :SpearOpen 1<cr>
" nnoremap <silent> <C-j>    :SpearOpen 2<cr>
" nnoremap <silent> <C-k>    :SpearOpen 3<cr>
" nnoremap <silent> <C-l>    :SpearOpen 4<cr>
" nnoremap <silent> <C-S-N>  :SpearNext<cr>
" nnoremap <silent> <C-S-P>  :SpearPrev<cr>
