if !has('nvim') | finish | endif

fun! s:SetupColors()
  highlight RainbowDelimiterWhite   guifg=#FFFFFF ctermfg=White
  highlight RainbowDelimiterCyan    guifg=#00FFFF ctermfg=Cyan
  highlight RainbowDelimiterGreen   guifg=#00FF00 ctermfg=LightGreen
  highlight RainbowDelimiterYellow  guifg=#FFFF00 ctermfg=Yellow
  highlight RainbowDelimiterOrange  guifg=#FFaf00 ctermfg=DarkYellow
  highlight RainbowDelimiterRed     guifg=#FF5050 ctermfg=LightRed
  highlight RainbowDelimiterViolet  guifg=#FF87FF ctermfg=LightMagenta
endfun

augroup config_rainbow_delimiters
  au!
  au VimEnter * call s:SetupColors()
augroup END

" Color order
let g:rainbow_delimiters = {
      \ 'highlight': [
      \ 'RainbowDelimiterWhite',
      \ 'RainbowDelimiterCyan',
      \ 'RainbowDelimiterGreen',
      \ 'RainbowDelimiterYellow',
      \ 'RainbowDelimiterOrange',
      \ 'RainbowDelimiterRed',
      \ 'RainbowDelimiterViolet',
      \ ] }

