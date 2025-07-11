" if executable('wsl')
"   let g:gtfo#terminals = { 'win' : 'C:\Windows\System32\wsl.exe'}
" else
"   let g:gtfo#terminals = { 'win' : 'C:\Windows\System32\cmd.exe /k'}
" endif

let g:gtfo#terminals = { 'win' : 'powershell -NoLogo -NoExit -Command'}
