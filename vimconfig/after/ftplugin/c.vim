" *** THESE SETTINGS ALSO APPLY TO CPP FILES ***

" see: fo-table
setlocal formatoptions=rq1j

setlocal foldmethod=syntax

" If a parenthesis is open and a new line is made below,
" indent that line up to the last open parenthesis.
"
" example:
" function foo(int arg1, int arg2
"              int arg3)
setlocal cino=(0,l1,t0
