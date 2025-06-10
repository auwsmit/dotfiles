nnoremap <silent> <space>L }:call lightline#toggle()<cr>``

" layout + compatibility with other plugins {{{
let g:lightline = {
      \ 'colorscheme': 'mycustom',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'gitbranch', 'filename'] ],
      \   'right': [ ['percent', 'lineinfo'],
      \              ['fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'inactive': {
      \   'left': [ [], ['filename_i'] ],
      \   'right': [ ['percent', 'lineinfo_i'] ]
      \ },
      \ 'component': {
      \   'percent': '%3{LightLinePercent()}',
      \   'filename': '%{LightLineFilename(1)}',
      \   'filename_i': '%{LightLineFilename(0)}',
      \   'lineinfo': '%l,%c',
      \   'lineinfo_i': '%l/%L'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'fugitive': 'LightLineFugitive',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

let g:lightline.mode_map = {
      \ 'n' : ' N ', 'i' : ' I ',
      \ 'R' : ' R ', 'v' : ' V ',
      \ 'V' : ' VL', "\<C-v>": ' VB',
      \ 'c' : ' C ', 's' : ' S ',
      \ 'S' : ' SL', "\<C-s>": ' SB',
      \ 't': ' T ',
      \ }

fun! LightLinePercent()
  return line('w0') == 1 && line('w$') == line('$') ? 'All'
        \: line('.') == 1 ? 'Top'
        \: line('.') == line('$') ? 'Bot'
        \: float2nr(100*(1.0*line('.')/line('$'))).'%'
endfun

fun! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfun
fun! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfun
fun! LightLineFilename(active)
  let fname = expand(a:active ? '%:~:.' : '%:p')
  return fname =~ '__Tagbar__*' ? 'Tagbar' :
        \ fname =~ 'undotree_*\|diffpanel_*' ? '' :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfun

fun! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = 'β ' " βranch, with a B
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfun

fun! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfun
fun! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfun
fun! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfun
fun! LightLineMode()
  let fname = expand('%:t')
  return lightline#mode()
endfun

let g:tagbar_status_func = 'TagbarStatusFunc'
fun! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfun
