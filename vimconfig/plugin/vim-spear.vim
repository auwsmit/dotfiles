let g:spear_delete_blank_lines = 0
let g:spear_delete_invalid_files = 0
let g:spear_quit_on_save = 1
let g:spear_save_on_change = 0
let g:spear_next_prev_cycle = 1
let g:spear_convert_backslashes = 0

nnoremap <silent> <space>A :call spear#add_file()<cr>
nnoremap <silent> <space>X :call spear#remove_file()<cr>
nnoremap <silent> <c-s>    :call spear#toggle_menu()<cr>
nnoremap <silent> <c-h>    :call spear#open_file(1)<cr>
nnoremap <silent> <c-j>    :call spear#open_file(2)<cr>
nnoremap <silent> <c-k>    :call spear#open_file(3)<cr>
nnoremap <silent> <c-l>    :call spear#open_file(4)<cr>
nnoremap <silent> <c-.>    :call spear#next_prev_file('next')<cr>
nnoremap <silent> <c-,>    :call spear#next_prev_file('prev')<cr>

" let g:spear_create_commands = 1
" " all neatly around home row
" nnoremap <silent> <space>A :SpearAdd<cr>
" nnoremap <silent> <space>X :SpearRemove<cr>
" nnoremap <silent> <C-m>    :SpearToggle<cr>
" nnoremap <silent> <C-h>    :SpearOpen 1<cr>
" nnoremap <silent> <C-j>    :SpearOpen 2<cr>
" nnoremap <silent> <C-k>    :SpearOpen 3<cr>
" nnoremap <silent> <C-l>    :SpearOpen 4<cr>
" " < previous, and > next in the list
" nnoremap <silent> <C-.>    :SpearNext<cr>
" nnoremap <silent> <C-,>    :SpearPrev<cr>
