" Maintainer:  Austin Smith <AssailantLF@gmail.com>
" Last touched on Nov. 10, 2014

"   ** INDEX **
"
"   0 NEOBUNDLE
"   1 GENERAL
"   2 APPEARANCE/THEMIMG
"   3 KEYS/MAPS/ALIASES
"   4 VIM PLUGINS
"
"  Settings are reasonably grouped between
"  between white spaces for easy navigation
"  (tip: use { and })

" vim settings over vi settings
" must be first, because it changes other options as a side effect
set nocompatible

" ======================================================================
"   ** NEOBUNDLE **
" ======================================================================

" my way of dealing with swapping
" between Linux and Windows for now
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

" *core plugins*
NeoBundleFetch 'Shougo/neobundle.vim' " The one.

" *main plugins*
NeoBundle 'flazz/vim-colorschemes'    " all the colorschemes
NeoBundle 'kien/ctrlp.vim'            " fuzzy file search
NeoBundle 'tpope/vim-fugitive'        " git integration
NeoBundle 'mhinz/vim-startify'        " startup screen
NeoBundle 'bling/vim-airline'         " nicer statusbar/tabs
NeoBundle 'scrooloose/syntastic.git'  " real time error checking
NeoBundle 'Lokaltog/vim-easymotion'   " motion made easier
NeoBundle 'tpope/vim-surround'        " surroundings manipulation
NeoBundle 'xolox/vim-session'         " extension of default sessions
NeoBundle 'xolox/vim-misc'            " ^session requirement
NeoBundle 'godlygeek/tabular'         " text alignment extension
NeoBundle 'jiangmiao/auto-pairs'      " auto pair complete/delete
NeoBundle 'scrooloose/nerdcommenter'  " intensely orgasmic commenting

" *new/experimental*
NeoBundle 'Shougo/neocomplete.vim'    " auto completion thingy

" *toggleable panels*
NeoBundle 'sjl/gundo.vim'             " undo tree
NeoBundle 'scrooloose/nerdtree'       " nice file tree
NeoBundle 'majutsushi/tagbar'         " view tags easily
NeoBundle 'tpope/vim-vinegar'         " improved file manager

" TODO: Read manuals for:
" CtrlP
" Fugittive
" Airline
" Syntastic
" EasyMotion
" Surround
" Session
" Tabular
" NERD Commenter
" NERDTree
" Gundo
" Tagbar
" NeoBundle
" YouCompleteMe

" revision example:
"    NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" required
call neobundle#end()
filetype plugin indent on

" prompt to auto install plugins at startup
NeoBundleCheck

" End of NeoBundle Config



" ==================================================
"   ** GENERAL **
" ==================================================

set backspace=2       " backspace like most programs in insert mode
set nobackup          " i hate *~ and *.swp files and idgaf
set nowritebackup
set noswapfile
set history=100       " keep x lines of command line history
set showcmd           " display incomplete commands
set wildmenu          " better command-line completion
set incsearch         " do incremental searching
set autoindent        " always set autoindenting on
set browsedir=buffer  " open file tree in current buffer directory
set autoread          " autoload changed files
set hidden            " allow multiple modified buffers
set vb t_vb=          " plz stop the beeping
set clipboard=unnamed " Yank to the system clipboard by default

" use decimal instead of octal with ctrl+a and ctrl+x
set nrformats=

" enable mouse because why not
if has('mouse')
  set mouse=a
endif



" ==================================================
"   ** APPEARANCE/THEMING **
" ==================================================

" 256 color terminal, helps with terminal colorschemes
if has('unix')
  set t_Co=256
endif

" vim colorscheme
" favs: badwolf, grb256, wombat256mod
colorscheme badwolf

syntax on         " syntax highlighting
set ruler         " show the cursor position all the time
set number        " show line numbers
set laststatus=2  " always show status bar
set guioptions-=T " no toolbar.
set hlsearch      " highlight last search pattern
set cpoptions+=$  " $ as end marker for the change operator
set scrolloff=5   " keep 5 lines above & below for scope

" show tabs and eols
set listchars=tab:▶\ ,eol:¬,trail:·
"set list

" make it obvious where 80 characters is
" highlight 81st column if reached
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" file specific tab spacing
if has("autocmd")
  " enable file type detection
  filetype on

  " syntax of these languages is fussy over tabs vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab

  " customisations based on house-style (arbitrary)
  autocmd FileType vim        setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType html       setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css        setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4

  " treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
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



" ==================================================
"   ** KEYS/MAPS/ALIASES **
" ==================================================
"
" things related to plugins are located
" under their respective vim plugins section

" leader the easiest key to reach
let mapleader = " "

" swap ; and : for pinky's sake
noremap ; :
noremap : ;

" swap v and ctrl+v because block mode is better
nnoremap    v   <c-v>
nnoremap <c-v>     v
vnoremap    v   <c-v>
vnoremap <c-v>     v

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

" make enter break and do newlines
nnoremap <CR> o<Esc>

" backspace in normal mode
nnoremap <BS> i<BS><Esc>l

" make j and k go down by row instead of line,
" disabled for relativenumber navigation
"nmap j gj
"nmap k gk

" <Ctrl-l> removes any search highlighting, redraws screen
nnoremap <C-l> :nohl <CR> <C-l>

" <Ctrl-c> as alternative ESC
noremap <C-c> <esc>

" get off my lawn
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

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
noremap <silent> ,o :wincmd o<CR>
noremap <silent> ,= :wincmd =<CR>
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

" clear white spaces
cabbrev clearwhites %s/\s\+$//e



" ==================================================
"   ** VIM PLUGINS **
" ==================================================
"
" If you don't have a certain plugin installed,
" you should remove any corresponding settings

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

" EasyMotion
" search whole screen instead of below the cursor
" ..I'm pretty lazy
nmap <leader>w H<Plug>(easymotion-w)
nmap <leader>W H<Plug>(easymotion-W)

" NERDTree
nnoremap <Tab> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeToggle 

" Tagbar
nnoremap <leader>t :TagbarToggle<CR>

" CtrlP buffer map
nnoremap <leader>p :CtrlPBuffer<CR>

" Gundo
nnoremap <leader>z :GundoToggle<CR>

" Tabular
noremap <leader>= :Tabularize/

" Airline
" enable tabs, duh
let g:airline#extensions#tabline#enabled = 1

" Sessions
let g:session_directory       = "~/.vim/session"
let g:session_autoload        = "no"
let g:session_autosave        = "no"
let g:session_command_aliases = 1
nnoremap <leader>so :OpenSession 
nnoremap <leader>ss :SaveSession 
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" Startify
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
