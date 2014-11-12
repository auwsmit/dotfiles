" Maintainer:  Austin Smith <AssailantLF@gmail.com>
" Last touched on Nov. 11, 2014

" ** INDEX ** (kinda pointless with folds)                {{{1
" ============================================================
"
" NEOBUNDLE
" GENERAL
" APPEARANCE/VISUAL
" KEYS/MAPS/ALIASES
" VIM PLUGINS
"
" settings are reasonably grouped between
" between white spaces for easy navigation
" (tip: use { and })

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
NeoBundle 'scrooloose/Syntastic.git'  " real time error checking
NeoBundle 'kien/CtrlP.vim'            " fuzzy file search
NeoBundle 'Lokaltog/vim-EasyMotion'   " motion made easier
NeoBundle 'godlygeek/Tabular'         " text alignment extension
NeoBundle 'terryma/vim-expand-region' " convenient visual selection
NeoBundle 'xolox/vim-Session'         " extension of default sessions
NeoBundle 'xolox/vim-misc'            " ^session requirement
NeoBundle 'bling/vim-Airline'         " better aesthetics for UI
NeoBundle 'mhinz/vim-Startify'        " startup screen

" *NEW/EXPERIMENTAL*

" *TOGGLEABLE PANELS*
if has('python')
  NeoBundle 'sjl/Gundo.vim'           " undo tree
endif
NeoBundle 'scrooloose/NERDtree'       " nice file tree
NeoBundle 'majutsushi/Tagbar'         " view tags easily

" revision example:
"    NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

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
set clipboard=unnamed  " Yank to the system clipboard by default

" use decimal instead of octal with ctrl+a and ctrl+x
set nrformats=

" enable mouse because why not
if has('mouse')
  set mouse=a
endif



" ** APPEARANCE/VISUAL **                                 {{{1
" ============================================================

" 256 color terminal, helps with terminal colorschemes
if has('unix')
  set t_Co=256
endif

" vim colorscheme
" favs: badwolf, xoria256, grb256, wombat256mod
colorscheme badwolf

syntax on             " syntax highlighting
set ruler             " show the cursor position all the time
set number            " show line numbers
set laststatus=2      " always show status bar
set guioptions-=T     " no toolbar.
set hlsearch          " highlight last search pattern
set showcmd           " display incomplete commands
set wildmenu          " better command-line completion
set cpoptions+=$      " $ as end marker for the change operator
set scrolloff=8       " keep some lines above & below for scope
set lazyredraw        " redraw only when we need to
set foldmethod=marker " default fold method

" show tabs and eols
set listchars=tab:▶\ ,eol:¬,trail:·
"set list

" make it obvious where 80 characters is
" highlight 81st column if reached
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

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
  autocmd FileType c setlocal foldmethod=syntax foldnestmax=5
endif

" window size
"set lines=37 columns=74

" gvim specific
if has('gui_running')
  " dem fonts
  if has('unix')
    set guifont=Liberation\ Mono\ 11
  else
    set guifont=liberation_mono:h11
  endif
endif



" ** KEYS/MAPS/ALIASES **                                 {{{1
" ============================================================
"
" anything related to plugins is located
" under its respective vim plugins section

" * REMAPS OF DEFAULTS *      {{{2

" swap ; and : for pinky's sake
noremap ; :
noremap : ;

" quick insert-mode escape
inoremap jk <Esc>

" swap v and ctrl+v because block mode is better
nnoremap    v   <c-v>
nnoremap <c-v>     v
vnoremap    v   <c-v>
vnoremap <c-v>     v

" <CR> to EOF, #<CR> to line #
nnoremap <CR> G

" backspace to BOF
nnoremap <BS> gg

" jump to the end of pasted text
" useful for pasting multi-lines of text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" <Ctrl-l> removes any search highlighting, redraws screen
nnoremap <C-l> :nohl <CR> <C-l>

" * LEADER MAPS *             {{{2

" leader the easiest key to reach
let mapleader = " "

" switch to last buffer
nnoremap <leader><Tab> :b#<cr>

" open vimrc
if has('unix')
  nnoremap <leader>v :e ~/.vimrc<CR>
  nnoremap <leader>V :tabnew ~/.vimrc<CR>
else
  nnoremap <leader>v :e ~/_vimrc<CR>
  nnoremap <leader>V :tabnew ~/_vimrc<CR>
endif

" toggle relativenumber
nnoremap <leader>n :set rnu! rnu?<CR>

" copy and paste from system clipboard
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" * SHORTCUTS/ALIASES *       {{{2

" maps to make handling windows a bit easier
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

" make tabs slightly more convenient
cabbrev te tabnew
cabbrev tc tabclose

" clear trailing white spaces
cabbrev clearwhites %s/\s\+$//e



" ** VIM PLUGINS ** (plugin related settings)             {{{1
" ============================================================
"
" If you don't have a certain plugin installed,
" you should remove any corresponding settings

" Syntastic {{{2
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

" CtrlP {{{2
" buffer search
nnoremap <leader>pb :CtrlPBuffer<CR>

" Tabular {{{2
noremap <leader>= :Tabularize/

" vim-expand-region {{{2
" v / ctrl+v to expand/shrink selection
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Sessions {{{2
let g:session_directory       = "~/.vim/session"
let g:session_autoload        = "no"
let g:session_autosave        = "no"
let g:session_command_aliases = 1
cabbrev SO :OpenSession 
cabbrev SS :SaveSession 
cabbrev SD :DeleteSession
cabbrev SC :CloseSession

" Airline {{{2
" enable tabs, duh
let g:airline#extensions#tabline#enabled = 1

" Startify {{{2
" custom header, ironically at the bottom
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

" Gundo {{{2
nnoremap <leader>u :GundoToggle<CR>

" NERDTree {{{2
nnoremap <Tab> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeToggle 

" Tagbar {{{2
nnoremap <leader>t :TagbarToggle<CR>

