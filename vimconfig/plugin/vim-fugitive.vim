nnoremap <space>GS :G<cr>
nnoremap <space>GD :Gdiffsplit<cr>
nnoremap <space>Gd :Gdiffsplit HEAD<cr>
nnoremap <space>GW :Gwrite<cr>
nnoremap <space>GC :G commit<cr>
nnoremap <space>GL :G log<cr>
nnoremap <space>GG :Ggrep<space>
nnoremap <space>GP :G push

fun! s:fugitive_maps()
  nnoremap <buffer> q :bdelete<cr>
  nnoremap <buffer> gq q
endfun

augroup config_Fugitive
  au!
  au FileType fugitive call s:fugitive_maps()
augroup END
