" treat .vs files as GLSL vertex shader files
if expand('%:e') == 'vs'
  set ft=glsl
  syntax on
endif
