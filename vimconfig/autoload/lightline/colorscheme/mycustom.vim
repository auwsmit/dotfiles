" =============================================================================
" Filename: autoload/lightline/colorscheme/mycustom.vim
" Original Author: auwsmit
" License: MIT License
" =============================================================================

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ ['gray1', '#0a9dff', 'bold'], ['white', 'gray3'] ]
let s:p.normal.right = [ ['gray1', '#0a9dff', 'bold'] ]
let s:p.normal.middle = [ [ 'gray8', 'gray2' ] ]

let s:p.inactive.left = [ ['gray6', 'gray2'], ['gray6', 'gray2'] ]
let s:p.inactive.right = s:p.inactive.left
let s:p.inactive.middle = [ ['white', 'gray1'] ]

let s:p.insert.left = [ ['gray1', '#aeee00', 'bold'], ['white', 'gray3'] ]
let s:p.insert.right = [ ['gray1', '#aeee00', 'bold'] ]
let s:p.insert.middle = s:p.normal.middle

let s:p.replace.left = [ ['gray1', '#ff2c4b', 'bold'], ['white', 'gray3'] ]
let s:p.replace.right = [ ['gray1', '#ff2c4b', 'bold'] ]
let s:p.replace.middle = s:p.normal.middle

let s:p.visual.left = [ ['gray1', '#ffa724', 'bold'], ['white', 'gray3'] ]
let s:p.visual.right = [ ['gray1', '#ffa724', 'bold'] ]

let s:p.tabline.left   = [ ['gray9', 'gray4'] ]
let s:p.tabline.tabsel = [ ['gray9', 'gray1'] ]
let s:p.tabline.right  = [ ['gray9', 'gray3'] ]
let s:p.tabline.middle = [ ['gray2', 'gray8'] ]

let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
let s:p.normal.warning = [ [ 'gray1', 'yellow' ] ]

let g:lightline#colorscheme#mycustom#palette = lightline#colorscheme#fill(s:p)
