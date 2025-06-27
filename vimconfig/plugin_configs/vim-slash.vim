" in case indexed-search isn't installed for some reason
fun! s:IndexedSearchInstallCheck()
  if !exists("g:loaded_indexed_search")
    noremap <silent> <plug>(slash-after) zz
  else
    ShowSearchIndex
  endif
endfun

" slash + indexed-search, also centered search
noremap <silent> <plug>(slash-after) :<c-u>call <sid>IndexedSearchInstallCheck()<cr>zz
xunmap <plug>(slash-after)
