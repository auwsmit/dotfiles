let map_prefix = '<Space>~'
let maps = ['~',    'c',     'b',      'k',     's']
let cmds = ['Snek', 'Camel', 'CamelB', 'Kebab', 'Screm']

for i in range(0,len(maps)-1)
  exec 'noremap <silent> <Plug>('.cmds[i].'Case) :'.cmds[i].'<CR>'.
        \ ':silent! call repeat#set("\<Plug>('.cmds[i].'Case)", v:count)<CR>'
  exec 'noremap '.map_prefix.maps[i].' <Plug>('.cmds[i].'Case)'
endfor
" don't switch case if the mapping times out
exec 'noremap '.map_prefix.' <NOP>'
