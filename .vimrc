" Maintainer:	Austin Smith <AssailantLF@gmail.com>
" Last touched on Nov. 9, 2014

" 	** INDEX **
"
"   0 NEOBUNDLE
"	  1 GENERAL
"	  2 APPEARANCE/THEMIMG
"	  3 KEYS/MAPS/ALIASES
"	  4 VIM PLUGINS
"
"	Settings are reasonably grouped between
"	between white spaces for easy navigation
"	(tip: use { and })

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"   ** NEOBUNDLE **

" required
if has('vim_starting')
  if has('unix')
    set runtimepath+=/home/austin/.vim/bundle/neobundle.vim/
  else
    set runtimepath+=$VIM/vimfiles/bundle/neobundle.vim/
  endif
endif
if has('unix')
  call neobundle#begin(expand('/home/austin/.vim/bundle'))
else
  call neobundle#begin(expand('$VIM/vimfiles/bundle'))
endif

" core plugins
NeoBundleFetch 'Shougo/neobundle.vim'	  " The one.

" main plugins
NeoBundle 'flazz/vim-colorschemes'      " all the colorschemes
NeoBundle 'kien/ctrlp.vim'              " fuzzy file search
NeoBundle 'tpope/vim-fugitive'          " git integration
NeoBundle 'mhinz/vim-startify'          " startup screen
NeoBundle 'bling/vim-airline'           " nicer statusbar/tabs
NeoBundle 'scrooloose/syntastic.git'    " real time error checking
NeoBundle 'sjl/gundo.vim'               " undo tree
NeoBundle 'scrooloose/nerdtree'         " nice file tree
NeoBundle 'Lokaltog/vim-easymotion'     " motion made easier
NeoBundle 'tpope/vim-surround'          " surroundings manipulation
NeoBundle 'xolox/vim-session'           " more extensive sessions
NeoBundle 'xolox/vim-misc'              " ^session requirement

" unsure/experimental

" toggleable panels (togglable?)
NeoBundle 'majutsushi/tagbar'		        " view tags easily
NeoBundle 'tpope/vim-vinegar'		        " improved file manager

" revision example:
"	NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" required
call neobundle#end()
filetype plugin indent on

" prompt to auto install plugins at startup
NeoBundleCheck

" End of NeoBundle Config



"   ** GENERAL **

set backspace=2		    " Backspace like most programs in insert mode
set nobackup 		      " I hate *~ and *.swp files and idgaf
set nowritebackup
set noswapfile
set history=100		    " keep x lines of command line history
set showcmd		        " display incomplete commands
set wildmenu		      " better command-line completion
set incsearch		      " do incremental searching
set autoindent		    " always set autoindenting on
set browsedir=buffer	" open file tree in current buffer directory
set autoread		      " autoload changed files
set hidden		        " allow multiple modified buffers
set vb t_vb=		      " plz stop the beeping

" uses decimal instead of octal with ctrl+a and ctrl+x
set nrformats=

" Enable mouse because why not
if has('mouse')
  set mouse=a
endif



"   ** APPEARANCE/THEMING **

" Vim Colorscheme
" favs: grb256, wombat256mod, candyman
colorscheme wombat256mod

syntax on	    	      " syntax highlighting on
"set cursorline		    " highlight current line
set ruler		          " show the cursor position all the time
set number		        " show line numbers
set numberwidth=5	    " length of ints in the line numbers
set laststatus=2	    " always show status bar
set guioptions-=T	    " no toolbar.
set hlsearch		      " highlight last search pattern
set cpoptions+=$	    " $ as end marker for the change operator

" Use spaces for tabs and make them 2 chars long
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Make it obvious where 80 characters is
" Highlight 81st column if reached
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" 256 color terminal, helps with terminal colorschemes
if has('unix')
  set t_Co=256
endif

" window size
"set lines=37 columns=74

" gvim specific
if has('gui_running')
  if has('unix')
    set guifont=Liberation\ Mono\ 11
  else
    set guifont=liberation_mono:h11
  endif
endif



"   ** KEYS/MAPS/ALIASES **
"
" plugin related shortcuts are located
" under their respective vim plugins section

" leader the easiest key to reach
let mapleader = " "

" swap ; and : for pinky's sake
nnoremap ; :
nnoremap : ;

" swap v and ctrl+v because block mode is better
nnoremap    v   <c-v>
nnoremap <c-v>     v
vnoremap    v   <c-v>
vnoremap <c-v>     v

" switch to last buffer, like alt+tab
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
nnoremap <silent><leader>n :set rnu! rnu? <cr>

" leader+[ / ] to switch tabs
nnoremap <silent><leader>[ :tabprev<CR>
nnoremap <silent><leader>] :tabnext<CR>

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



"   ** VIM PLUGINS **
"
"	if you don't have these plugins
"	installed, you should probably
"	remove any corresponding settings

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

" EasyMotion
" search whole screen instead of below the cursor
nmap <leader>w H<Plug>(easymotion-w)
nmap <leader>W H<Plug>(easymotion-W)

" NERD Tree shortcut
nnoremap <leader>f :NERDTreeToggle 

" Tagbar shortcut
nnoremap <leader>t :TagbarToggle<CR>

" CtrlP buffer shortcut
nnoremap <leader>p :CtrlPBuffer<CR>

" Gundo shortcut
nnoremap <leader>z :GundoToggle<CR>

" Airline
" enable tabs.. duh
let g:airline#extensions#tabline#enabled = 1

" Sessions
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
nnoremap <leader>so :OpenSession
nnoremap <leader>ss :SaveSession
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" Startify
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
