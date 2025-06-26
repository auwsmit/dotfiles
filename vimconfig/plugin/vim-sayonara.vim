" close buffer + preserve windows
nnoremap gs :Sayonara!<cr>
" close buffer + close window
nnoremap gS :Sayonara<cr>
" stahp
nnoremap <Space>gs :echo 'did you mean <'.'Space>GS?'<CR>
" prompt to close vim when closing the last file
let g:sayonara_confirm_quit = 1
let g:sayonara_plugged = 1
