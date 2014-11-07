" Maintainer:	Austin Smith <AssailantLF@gmail.com>
" Last touched on Nov. 6, 2014
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc (probably C:/Program Files/Vim)
"	    for OpenVMS:  sys$login:.vimrc



" 	** INDEX **
"
"	0 NEOBUNDLE
"	1 GENERAL
"	2 APPEARANCE/THEMIMG
"	3 KEYS/MAPS/ALIASES
"	4 VIM PLUGINS
"
"	Settings are reasonably grouped between
"	between white spaces for easy navigation
"	(tip: use { and })

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"	** NEOBUNDLE **

" required
if has('vim_starting')
      set runtimepath+=/home/austin/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('/home/austin/.vim/bundle'))

" core plugins
NeoBundleFetch 'Shougo/neobundle.vim'	" The one.

" main plugins
NeoBundle 'flazz/vim-colorschemes'	" all the colorschemes
NeoBundle 'kien/ctrlp.vim'		" fuzzy file search
NeoBundle 'tpope/vim-fugitive'		" git-to-vim integration
NeoBundle 'mhinz/vim-startify'		" nice startup screen
NeoBundle 'bling/vim-airline'		" nicer statusbar/tabs
NeoBundle 'scrooloose/syntastic.git'	" real time error checking
NeoBundle 'sjl/gundo.vim'		" undo tree
NeoBundle 'Lokaltog/vim-easymotion'	" motion made easier

" toggleable panels (togglable?)
NeoBundle 'majutsushi/tagbar'		" View tags easily
NeoBundle 'tpope/vim-vinegar'		" Improved file manager

" Revision example:
"	NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" required
call neobundle#end()
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" End NeoBundle Scripts-------------------------



"	** GENERAL **

set backspace=2		" Backspace like most programs in insert mode
set nobackup 		" I hate *~ and *.swp files and idgaf
set nowritebackup
set noswapfile
set history=100		" keep x lines of command line history
set showcmd		" display incomplete commands
set wildmenu		" better command-line completion
set incsearch		" do incremental searching
set autoindent		" always set autoindenting on
set cpoptions+=$	" use $ as an end marker for change
set browsedir=buffer	" open file tree in current buffer directory
set autoread		" auto load changed file if unedited in vim

" Enable mouse because why not
if has('mouse')
	set mouse=a
endif



"	** APPEARANCE/THEMING **

" Vim Colorscheme
colorscheme wombat256mod

" window size
set lines=37 columns=74

set cursorline		" highlight current line
set ruler		" show the cursor position all the time
set number		" show line numbers
set relativenumber	" numbers relative to current line
set numberwidth=5	" length of ints in the line numbers
set laststatus=2	" always show status bar
set guioptions-=T	" no toolbar.
set hlsearch		" highlight last search pattern
syntax on		" syntax highlighting on

" Make it obvious where 80 characters is
" Highlight 81st column if reached
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Make trailing whitespace, and non-breaking spaces visible,
" disabled for being annoying
" exec "set listchars=trail:\uB7,nbsp:~"
" set list

" 256 color terminal, helps with terminal colorschemes
if has('unix')
	set t_Co=256
endif

" gVim specific
if has("gui_running")
	"my gui text is smaller, so the window needs to be bigger
	set lines=45 columns=86
endif



"	** KEYS/MAPS/ALIASES **
"
"	Plugin related shortcuts are located
"	under their respective Vim Plugins section

" Leader
let mapleader = " "

" swap ; and : for pinky's sake
nnoremap ; :
nnoremap : ;

" opens file tree
nnoremap <leader>f :Explore!<CR>

" switch to last buffer
nnoremap <leader>e :b#<CR>

" open vimrc
nnoremap <leader>v :e ~/.vimrc<CR>
nnoremap <leader>V :tabnew ~/.vimrc<CR>

" toggle relativenumbers
nnoremap <silent><leader>n :set rnu! rnu? <cr>

" swap v and ctrl+v because block mode is better
nnoremap    v   <C-V>
nnoremap <C-V>     v
vnoremap    v   <C-V>
vnoremap <C-V>     v

" makes j and k go down by row instead of line,
" disabled for relativenumber navigation
" nmap j gj
" nmap k gk

" <Ctrl-l> removes any search highlighting, redraws screen
nnoremap <silent> <C-l> :nohl <CR> <C-l>

" <Ctrl-c> as alternative ESC
noremap <C-c> <esc>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Maps to make handling windows a bit easier
"
" Creating windows
noremap <silent> ,s :wincmd s<CR>
noremap <silent> ,v :wincmd v<CR>
" Navigating between windows
noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>
noremap <silent> ,p :wincmd p<CR>
" Moving windows around
noremap <silent> ,ml <C-W>L
noremap <silent> ,mk <C-W>K
noremap <silent> ,mh <C-W>H
noremap <silent> ,mj <C-W>J
" Resizing windows
noremap <silent> ,o :wincmd o<CR>
noremap <silent> ,= :wincmd =<CR>
noremap <silent> <C-Left> :vertical resize -10<CR>
noremap <silent> <C-Up> :resize +10<CR>
noremap <silent> <C-Down> :resize -10<CR>
noremap <silent> <C-Right> :vertical resize +10<CR>
" Closing windows
noremap <silent> ,cc :close<CR>
noremap <silent> ,cj :wincmd j<CR>:close<CR>
noremap <silent> ,ck :wincmd k<CR>:close<CR>
noremap <silent> ,ch :wincmd h<CR>:close<CR>
noremap <silent> ,cl :wincmd l<CR>:close<CR>

" Command aliases
"
" make tabs easier to use
cabbrev tp tabprev
cabbrev tn tabnext
cabbrev tf tabfirst
cabbrev tl tablastg



"	** VIM PLUGINS **
"	if you don't have these plugins
"	installed, you should probably
"	remove any corresponding settings

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

" Tagbar shortcut
nnoremap <leader>t :TagbarToggle<CR>

" CtrlP buffer shortcut
nnoremap <leader>p :CtrlPBuffer<CR>

" Airline
" enable tabs.. duh
let g:airline#extensions#tabline#enabled = 1

" Gundo shortcut
nnoremap <leader>z :GundoToggle<CR>

" Drag visuals keys
" lets you literally drag visual selections
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()
" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1
