" =============================================================================
" Filename: autoload/lightline/colorscheme/mypowerline.vim
" Original Author: itchyny
" Author Of Small Adjustments: auwsmit
" License: MIT License
" Last Change: 2017/11/14 15:38:27.
" =============================================================================

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ ['brightgreen', 'darkestgreen'], ['darkestgreen', 'brightgreen', 'bold'], ['white', 'gray4'] ]
let s:p.normal.right = [ ['gray9', 'gray4'], ['gray8', 'gray2'] ]
let s:p.inactive.left = [ ['gray4', 'gray1'], ['gray4', 'gray1'] ]
let s:p.inactive.right = s:p.inactive.left
let s:p.insert.left = [ ['white', 'darkestcyan'], ['darkestcyan', 'white', 'bold'], ['white', 'darkblue'] ]
let s:p.insert.right = [ [ 'mediumcyan', 'darkblue' ], [ 'mediumcyan', 'darkestblue' ] ]
let s:p.replace.left = [ ['brightred', 'darkestred'], ['white', 'brightred', 'bold'], ['white', 'gray4'] ]
let s:p.visual.left = [ ['brightorange', 'darkred'], ['darkred', 'brightorange', 'bold'], ['white', 'gray4'] ]
let s:p.normal.middle = [ [ 'gray7', 'gray2' ] ]
let s:p.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]
let s:p.replace.middle = s:p.normal.middle
let s:p.replace.right = s:p.normal.right
let s:p.tabline.left = [ [ 'gray9', 'gray4' ] ]
let s:p.tabline.tabsel = [ [ 'gray9', 'gray1' ] ]
let s:p.tabline.middle = [ [ 'gray2', 'gray8' ] ]
let s:p.tabline.right = [ [ 'gray9', 'gray3' ] ]
let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
let s:p.normal.warning = [ [ 'gray1', 'yellow' ] ]

let g:lightline#colorscheme#mypowerline#palette = lightline#colorscheme#fill(s:p)
