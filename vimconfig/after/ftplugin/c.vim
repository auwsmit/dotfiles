" *** THESE SETTINGS ALSO APPLY TO CPP FILES ***

" see: fo-table
setlocal formatoptions=rq1j

" tab settings
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

" If a parenthesis is open and a new line is made below,
" indent that line up to the last open parenthesis.
"
" example:
" function foo(int arg1, int arg2
"              int arg3)
setlocal cino=(0)
