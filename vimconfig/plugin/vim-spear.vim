let g:prompt_delete_blank_lines = 1
let g:prompt_delete_invalid_files = 1

nnoremap <space>A :SpearAdd<cr>
nnoremap <space>X :SpearDelete<cr>
nnoremap <c-m>    :SpearToggle<cr>
nnoremap <c-h>    :SpearOpen 1<cr>
nnoremap <c-j>    :SpearOpen 2<cr>
nnoremap <c-k>    :SpearOpen 3<cr>
nnoremap <c-l>    :SpearOpen 4<cr>
nnoremap <c-.>    :SpearNext<cr>
nnoremap <c-,>    :SpearPrev<cr>
