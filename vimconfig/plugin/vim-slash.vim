let g:indexed_search_mappings = 0
let g:indexed_search_max_lines = 50000
" slash + indexed-search, also centered results
noremap <silent> <plug>(slash-after) :<c-u>ShowSearchIndex<cr>zz
xunmap <plug>(slash-after)
