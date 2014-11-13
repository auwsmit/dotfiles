" Maintainer:  Austin Smith <AssailantLF@gmail.com>
" Last touched on Nov. 13, 2014

" *Fold Command Reference*  {{{1
" Opening and Closing Folds
"   h: zo
" Moving Over Folds
"   h: zj

" ** NEOBUNDLE ** (less stable, more featured Vundle)     {{{1
" ============================================================

" required begin {{{2
if has('vim_starting')
  if has('unix')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  else
    set runtimepath+=$VIM/vimfiles/bundle/neobundle.vim/
  endif
endif
if has('unix')
  call neobundle#begin(expand('~/.vim/bundle'))
else
  call neobundle#begin(expand('$VIM/vimfiles/bundle'))
endif

" *CORE PLUGINS*
NeoBundleFetch 'Shougo/neobundle.vim' " The one.

" *MAIN PLUGINS* {{{2
NeoBundle 'flazz/vim-colorschemes'    " all the colorschemes
NeoBundle 'scrooloose/NERDCommenter'  " intensely pleasant commenting
NeoBundle 'tpope/vim-Fugitive'        " git integration
NeoBundle 'tpope/vim-Surround'        " surroundings manipulation
NeoBundle 'tpope/vim-Vinegar'         " improved file manager
NeoBundle 'tpope/vim-unimpaired'      " pairs of handy bracket mappings
NeoBundle 'scrooloose/Syntastic.git'  " real time error checking
NeoBundle 'kien/CtrlP.vim'            " fuzzy file search
NeoBundle 'Lokaltog/vim-EasyMotion'   " motion made easier
NeoBundle 'godlygeek/Tabular'         " text alignment extension
NeoBundle 'terryma/vim-expand-region' " convenient visual selection
NeoBundle 'xolox/vim-session'         " extension of default sessions
NeoBundle 'xolox/vim-misc'            " ^session requirement
NeoBundle 'bling/vim-Airline'         " better aesthetics for UI
NeoBundle 'mhinz/vim-Startify'        " startup screen

" *NEW/EXPERIMENTAL*

" *TOGGLEABLE PANELS*
if has('python')
  NeoBundle 'sjl/Gundo.vim'           " undo tree
endif
NeoBundle 'majutsushi/Tagbar'         " view tags easily

" TODO: Read manuals for... {{{2
" CtrlP
" Fugitive
" Airline
" Syntastic
" Surround
" Session
" Tabular
" NERD Commenter
" NERDTree
" Gundo
" Tagbar
" NeoBundle

" required end {{{2
call neobundle#end()
filetype plugin indent on

" prompt to auto install plugins at startup
NeoBundleCheck

" ** GENERAL **                                           {{{1
" ============================================================

set backspace=2        " backspace like most programs in insert mode
set nobackup           " I hate backup files and idgaf
set nowritebackup
set noswapfile
set history=100        " keep x lines of command line history
set incsearch          " do incremental searching
set autoindent         " always set autoindenting on
set browsedir=buffer   " open file tree in current buffer directory
set autoread           " autoload changed files
set hidden             " allow multiple modified buffers
set vb t_vb=           " plz stop the beeping

" use decimal instead of octal with ctrl+a and ctrl+x
set nrformats=

" don't save options with sessions
set sessionoptions-=options

" enable mouse because why not
if has('mouse')
  set mouse=a
endif

" disabled because :so% is easy
" Source (load) vimrc file after saving it
"if has("autocmd")
"  autocmd! bufwritepost .vimrc source $MYVIMRC
"endif

" ** APPEARANCE/VISUAL **                                 {{{1
" ============================================================

" 256 color terminal, helps with terminal colorschemes
if has('unix')
  set t_Co=256
endif

" vim colorscheme
" favs: badwolf, xoria256, grb256, wombat256mod
colorscheme koehler   " fallback default colorscheme
colorscheme badwolf

syntax on             " syntax highlighting
set ruler             " show the cursor position all the time
set number            " show line numbers
set laststatus=2      " always show status bar
set guioptions-=T     " no toolbar, it's ugly
set hlsearch          " highlight last search pattern
set showcmd           " display incomplete commands
set wildmenu          " better command-line completion
set cpoptions+=$      " $ as end marker for the change operator
set scrolloff=8       " keep some lines above & below for scope
set lazyredraw        " redraw only when we need to
set foldmethod=marker " default fold method
set nofoldenable      " default disabled folds, zi to toggle
set showbreak=↪       " character to show wrapped lines

" show tabs and eols
if has('unix')  " my unicode chars won't work in Windows
  set listchars=tab:▶\ ,eol:¬,trail:·,extends:❯,precedes:❮
endif

" make it obvious where 80 characters is
" highlight 81st column if reached
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" default tab settings
set tabstop=4 softtabstop=4 shiftwidth=4

" gvim specific
if has('gui_running')
  " dem fonts
  if has('unix')
    set guifont=Liberation\ Mono\ 11
  else
    set guifont=liberation_mono:h11
  endif
endif

" file type specific
if has("autocmd")
  " enable file type detection
  filetype on

  " tabs vs spaces
  autocmd FileType make       setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType vim        setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType html       setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css        setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4

  " fold settings
  autocmd FileType c setlocal foldmethod=syntax
endif

" resize splits when the window is resized
" change ; to : if you get an error
au VimResized * ;wincmd =

" ** KEYS/MAPS/ALIASES **                                 {{{1
" ============================================================
"
" anything related to plugins is located
" under its respective vim plugins section

" * REMAPS OF DEFAULTS *      {{{2

" swap ; and : for pinky's sake
noremap ; :
noremap : ;

" swap v and ctrl+v because block mode is better
nnoremap    v   <c-v>
nnoremap <c-v>     v
vnoremap    v   <c-v>
vnoremap <c-v>     v

" <CR> to EOF, #<CR> to line #
nnoremap <CR> G

" backspace to BOF
nnoremap <BS> gg

" split line (sister to [j]oin lines)
" the normal use of s is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" jump to the end of pasted text
" useful for pasting multi-lines of text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" <Ctrl-l> removes any search highlighting, redraws screen
nnoremap <C-l> :nohl <CR> <C-l>

" toggle highlighting indent columns
let g:indentguides_state = 0
function! IndentGuides() " {{{
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction " }}}
hi def IndentGuides guibg=#303030 ctermbg=234
nnoremap <leader>i :call IndentGuides()<cr>

" * SHORTCUTS/ALIASES *       {{{2

" quick insert-mode escape
inoremap jk <Esc>

" maps to make handling windows a bit easier
" might as well make these a plugin called 'comma-windows'
"
" creating windows
noremap <silent> ,s :wincmd s<CR>
noremap <silent> ,v :wincmd v<CR>
" navigating between windows
noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>
noremap <silent> ,p :wincmd p<CR>
" moving windows around
noremap <silent> ,ml <C-W>L
noremap <silent> ,mk <C-W>K
noremap <silent> ,mh <C-W>H
noremap <silent> ,mj <C-W>J
" resizing windows
noremap <silent> ,o     :wincmd o<CR>
noremap <silent> ,=     :wincmd =<CR>
noremap <silent> ,_     :wincmd _<CR>
noremap <silent> ,<BAR> :wincmd <BAR><CR>
noremap <silent> <C-Left>  :vertical resize -10<CR>
noremap <silent> <C-Up>    :resize +10<CR>
noremap <silent> <C-Down>  :resize -10<CR>
noremap <silent> <C-Right> :vertical resize +10<CR>
" closing windows
noremap <silent> ,cc :close<CR>
noremap <silent> ,cj :wincmd j<CR>:close<CR>
noremap <silent> ,ck :wincmd k<CR>:close<CR>
noremap <silent> ,ch :wincmd h<CR>:close<CR>
noremap <silent> ,cl :wincmd l<CR>:close<CR>

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" make tabs slightly more convenient
cabbrev te tabnew
cabbrev tc tabclose

" clear trailing white spaces
cabbrev clearwhites %s/\s\+$//e
" * LEADER MAPS *             {{{2

" leader the easiest key to reach
let mapleader = " "

" switch to last buffer
nnoremap <Leader><Tab> :b#<cr>

" open vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>V :tabnew $MYVIMRC<CR>

" toggle relativenumber
nnoremap <Leader>n :setlocal rnu! rnu?<CR>

" toggle showing list chars
nnoremap <Leader>l :set list! list?<CR>

" copy and paste from system clipboard
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" show only current fold
nnoremap <Leader>z zMzv

" ** VIM PLUGINS ** (plugin related settings)             {{{1
" ============================================================
"
" If you don't have a certain plugin installed,
" you should remove any corresponding settings

" CtrlP {{{2
nnoremap <Leader>f :CtrlP 
" buffer search
nnoremap <Leader>b :CtrlPBuffer<CR>

" Tabular {{{2
noremap <Leader>= :Tabularize/

" Gundo {{{2
nnoremap <Leader>u :GundoToggle<CR>

" NERDTree {{{2
" disabled because netrw is alright
"nnoremap <Tab> :NERDTreeToggle<CR>
"nnoremap <Leader>f :NERDTreeToggle 

" Tagbar {{{2
nnoremap <Leader>t :TagbarToggle<CR>

" vim-expand-region {{{2
" v / ctrl+v to expand/shrink selection
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Syntastic {{{2
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

" vim-sessions {{{2
let g:session_directory       = "~/.vim/session"
let g:session_autoload        = "no"
let g:session_autosave        = "no"
let g:session_command_aliases = 1
cabbrev SO OpenSession
cabbrev SS SaveSession
cabbrev SD DeleteSession
cabbrev SC CloseSession

" Airline {{{2
" enable tabs, duh
let g:airline#extensions#tabline#enabled = 1

" Startify {{{2
" custom header
let g:startify_custom_header = [
      \ '                                 ________  __ __        ',
      \ '            __                  /\_____  \/\ \\ \       ',
      \ '    __  __ /\_\    ___ ___      \/___//''/''\ \ \\ \    ',
      \ '   /\ \/\ \\/\ \ /'' __` __`\        /'' /''  \ \ \\ \_ ',
      \ '   \ \ \_/ |\ \ \/\ \/\ \/\ \      /'' /''__  \ \__ ,__\',
      \ '    \ \___/  \ \_\ \_\ \_\ \_\    /\_/ /\_\  \/_/\_\_/  ',
      \ '     \/__/    \/_/\/_/\/_/\/_/    \//  \/_/     \/_/    ',
      \ '',
      \ '',
      \ ]

