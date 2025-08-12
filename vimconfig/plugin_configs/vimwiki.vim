" vimwiki has way too many mappings, so disable them all.
" I can define my own as I need them
let g:vimwiki_key_mappings = { 'all_maps': 0, }
nmap <Space>W <Plug>VimwikiIndex
nmap <Space><Backspace> <Plug>VimwikiGoBackLink

augroup config_vimwiki
  au!
  au FileType vimwiki nmap <buffer> <CR> <Plug>VimwikiFollowLink
augroup END

" only use vimwiki in the vimwiki directory.
" files outside of the vimwiki directory will just be normal markdown.
let g:vimwiki_global_ext = 0
