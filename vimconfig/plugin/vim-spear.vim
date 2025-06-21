let g:spear_delete_blank_lines = 0
let g:spear_delete_invalid_files = 0
let g:spear_quit_on_save = 1
let g:spear_save_on_change = 0
let g:spear_next_prev_cycle = 1
let g:spear_convert_backslashes = 0

nnoremap <silent> <Space>A :call spear#add_file()<CR>
nnoremap <silent> <Space>X :call spear#remove_file()<CR>
nnoremap <silent> <C-s>    :call spear#toggle_menu()<CR>
nnoremap <silent> <C-h>    :call spear#open_file(1)<CR>
nnoremap <silent> <C-j>    :call spear#open_file(2)<CR>
nnoremap <silent> <C-k>    :call spear#open_file(3)<CR>
nnoremap <silent> <C-l>    :call spear#open_file(4)<CR>
nnoremap <silent> <M-.>    :call spear#next_prev_file('next')<CR>
nnoremap <silent> <M-,>    :call spear#next_prev_file('prev')<CR>

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
