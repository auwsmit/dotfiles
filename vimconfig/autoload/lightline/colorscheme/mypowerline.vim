" =============================================================================
" Filename: autoload/lightline/colorscheme/mypowerline.vim
" Original Author: auwsmit
" License: MIT License
" =============================================================================

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [
      \ ['brightgreen',  'darkestgreen'],
      \ ['darkestgreen', 'brightgreen', 'bold'],
      \ ['white',        'gray4'] ]
let s:p.normal.right = [
      \ ['white', 'gray4'],
      \ ['gray8', 'gray2'] ]
let s:p.normal.middle = [
      \ [ 'gray7', 'gray2' ] ]

let s:p.inactive.left = [
      \ ['gray5', 'gray2'],
      \ ['gray5', 'gray2'] ]
let s:p.inactive.right = s:p.inactive.left
let s:p.inactive.middle = [
      \ ['white', 'gray1'] ]

let s:p.insert.left = [
      \ ['mediumcyan',  'darkestblue'],
      \ ['darkestblue', 'mediumcyan', 'bold'],
      \ ['white',       'gray4'] ]
let s:p.insert.right = s:p.normal.right
let s:p.insert.middle = s:p.normal.middle

let s:p.replace.left = [
      \ ['firebrick1', 'darkred'],
      \ ['darkred',    'firebrick1', 'bold'],
      \ ['white',      'gray4'] ]
let s:p.replace.right = s:p.normal.right
let s:p.replace.middle = s:p.normal.middle

let s:p.visual.left = [
      \ ['brightorange', 'orangered4'],
      \ ['orangered4',   'brightorange', 'bold'],
      \ ['white',        'gray4'] ]

let s:p.tabline.left   = [ [ 'gray9', 'gray4' ] ]
let s:p.tabline.tabsel = [ [ 'gray9', 'gray1' ] ]
let s:p.tabline.right  = [ [ 'gray9', 'gray3' ] ]
let s:p.tabline.middle = [ [ 'gray2', 'gray8' ] ]

let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
let s:p.normal.warning = [ [ 'gray1', 'yellow' ] ]

let g:lightline#colorscheme#mypowerline#palette = lightline#colorscheme#fill(s:p)
