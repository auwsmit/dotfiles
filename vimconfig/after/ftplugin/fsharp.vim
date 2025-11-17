" treat .fs files as GLSL fragment shader files
if expand('%:e') == 'fs'
  set ft=glsl
  syntax on
endif
