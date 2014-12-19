" Maintainer:  Austin Smith <AssailantLF@gmail.com>
" Last touched on Dec. 18, 2014

" *Fold Command Reference*  {{{1
" Opening and Closing Folds
"   :h zo
" Moving Over Folds
"   :h zj

" ** NEOBUNDLE ** (less stable, more featured Vundle)     {{{1
" ============================================================

" required begin {{{2
if has('vim_starting')
  if has('win32')
    set runtimepath+=$VIM/vimfiles/bundle/neobundle.vim/
  else
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
endif
if has('win32')
  call neobundle#begin(expand('$VIM/vimfiles/bundle'))
else
  call neobundle#begin(expand('~/.vim/bundle'))
endif

" *CORE PLUGINS*
NeoBundleFetch 'Shougo/neobundle.vim'     " The one.

" *MAIN PLUGINS* {{{2
NeoBundle 'flazz/vim-colorschemes'        " all the colorschemes
NeoBundle 'scrooloose/NERDCommenter'      " intensely pleasant commenting
NeoBundle 'tpope/vim-fugitive'            " git integration
NeoBundle 'tpope/vim-surround'            " surroundings manipulation
NeoBundle 'tpope/vim-unimpaired'          " pairs of handy bracket mappings
NeoBundle 'scrooloose/Syntastic.git'      " real time error checking
NeoBundle 'kien/CtrlP.vim'                " fuzzy file search
NeoBundle 'godlygeek/Tabular'             " text alignment extension
NeoBundle 'xolox/vim-session'             " extension of default sessions
NeoBundle 'xolox/vim-misc'                " ^session requirement
NeoBundle 'SirVer/UltiSnips'              " snippet plugin
NeoBundle 'tommcdo/vim-exchange'          " easy text exchange for vim
NeoBundle 'jeetsukumaran/vim-filebeagle'  " vinegar inspired file manager
NeoBundle 'Yggdroot/indentLine'           " shows indents made by spaces
NeoBundle 'mhinz/vim-Startify'            " startup screen
NeoBundle 'bling/vim-airline'             " better aesthetics for UI
NeoBundle 'edkolev/tmuxline.vim'          " tmux status line

" *NEW/EXPERIMENTAL*

" *TOGGLEABLE PANELS*
if has('python')
  NeoBundle 'sjl/Gundo.vim'               " visual undo tree
endif
NeoBundle 'majutsushi/Tagbar'             " view ctags easily

" required end {{{2
call neobundle#end()
filetype plugin indent on

" auto install plugins at startup
NeoBundleCheck

" ** GENERAL **                                           {{{1
" ============================================================

" use Vim settings over Vi settings
set nocompatible

set encoding=utf-8   " consistent character encoding
set backspace=2      " backspace like most programs in insert mode
set nobackup         " I live on the edge breh
set nowritebackup
set noswapfile
set history=100      " keep x lines of command line history
set incsearch        " do incremental searching
set browsedir=buffer " open file tree in current buffer directory
set autoread         " autoload changed files
set hidden           " allow more than one modified buffer
set vb t_vb=         " plz stop the beeping

" use decimal instead of octal with ctrl+a and ctrl+x
set nrformats=

" don't save options with sessions
set sessionoptions-=options

" enable mouse because why not
if has('mouse')
  set mouse=a
endif

" make sure vim returns to the same line when you reopen a file
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" ** APPEARANCE/VISUAL **                                 {{{1
" ============================================================

" 256 color terminal, helps with terminal colorschemes
if has('unix')
  set t_Co=256
endif

" vim colorscheme
" favs: badwolf, xoria256, grb256
colorscheme desert    " fallback default colorscheme
colorscheme blackwolf

" set the status line the way Derek Wyatt likes it
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

syntax on             " syntax highlighting
set ruler             " show the cursor position all the time
set number            " show line numbers
set laststatus=2      " always show status bar
set guioptions-=T     " no toolbar, it's ugly
set hlsearch          " highlight last search pattern
set showcmd           " display incomplete commands
set wildmenu          " better command-line completion
set cpoptions+=$      " $ as end marker for the change operator
set autoindent        " always set autoindenting on
set linebreak         " break lines without breaking words
set lazyredraw        " redraw only when we need to
set foldmethod=marker " default fold method
set nofoldenable      " disable folds, zi to toggle
set list              " show invisible characters
set scrolloff=8       " keep some lines above & below for scope

" Windows/Linux differences..
if has('win32')
  " how to display invisible characters
  set listchars=tab:\|-,eol:¬,trail:·,extends:>,precedes:<
else
  set listchars=tab:▸\ ,eol:¬,trail:·,extends:❯,precedes:❮
endif

" maximized window in Windows
au GUIEnter * simalt ~x

" highlight 81st column and beyond if reached,
" this doesn't work well with gvim,
" see (:h ctermbg) if darkred doesn't fit with your colorscheme
highlight colorcolumn ctermbg=DarkRed
call matchadd('colorcolumn', '\%81v.', 100)

" default tab settings,
" see ftplugins for more
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" gvim specific
if has('gui_running')
  " dem fonts
  if has('win32')
    set guifont=liberation_mono:h11
  else
    set guifont=Liberation\ Mono\ 11
  endif
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
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" swap v and ctrl+v because block mode is better
nnoremap  v    <C-v>
nnoremap <C-v>  v
vnoremap  v    <C-v>
vnoremap <C-v>  v

" [S]plit line (sister to [J]oin lines)
" cc will still substitute the line like S would
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>

" Y yanks until EOL, more like D and C
" yy still yanks the whole line
nnoremap Y y$

" ctrl-c to copy system clipboard, because habits
vnoremap <C-c> "+y
" ctrl-v to paste in insert mode (from system clipboard)
inoremap <C-v> <Space><Esc>x"+P`]a
" also remap ctrl-l for literal inserts
inoremap <C-l> <C-v>

" jump to the end of pasted text
" useful for pasting multi-lines of text
vnoremap y y`]
vnoremap p p`]
nnoremap p p`]

" * SHORTCUTS/ALIASES *       {{{2

" quick insert-mode escape
inoremap jk <Esc>

" select entire buffer
nnoremap vaa ggvGg_

" maps to make handling windows a bit easier {{{
" mostly replaces ctrl+W with comma
"
" creating windows
nnoremap <silent> ,s :wincmd s<CR>
nnoremap <silent> ,v :wincmd v<CR>
" navigating between windows
nnoremap <silent> <C-h> <C-W>h<CR>
nnoremap <silent> <C-j> <C-W>j<CR>
nnoremap <silent> <C-k> <C-W>k<CR>
nnoremap <silent> <C-l> <C-W>l<CR>
nnoremap <silent> ,p :wincmd p<CR>
nnoremap <silent> ,w :wincmd w<CR>
" moving windows around
nnoremap <silent> ,ml <C-W>L
nnoremap <silent> ,mk <C-W>K
nnoremap <silent> ,mh <C-W>H
nnoremap <silent> ,mj <C-W>J
" resizing windows
nnoremap <silent> ,o     :wincmd o<CR>
nnoremap <silent> ,=     :wincmd =<CR>
nnoremap <silent> ,_     :wincmd _<CR>
nnoremap <silent> ,<Bar> :wincmd <Bar><CR>
nnoremap <silent> <C-Left>  :vertical resize -10<CR>
nnoremap <silent> <C-Up>    :resize +10<CR>
nnoremap <silent> <C-Down>  :resize -10<CR>
nnoremap <silent> <C-Right> :vertical resize +10<CR>
" closing windows
nnoremap <silent> ,cc :close<CR>
nnoremap <silent> ,cj :wincmd j<CR>:close<CR>
nnoremap <silent> ,ck :wincmd k<CR>:close<CR>
nnoremap <silent> ,ch :wincmd h<CR>:close<CR>
nnoremap <silent> ,cl :wincmd l<CR>:close<CR>
" }}}

" make tabs slightly more convenient
cabbrev te tabnew
cabbrev tc tabclose

" clear trailing white spaces
cabbrev clearwhites %s/\s\+$//e

" alias for the current file's directory
" more keystrokes, but easier to remember
cabbrev buffdir %:p:h

" KONAMI
nnoremap <UP><UP><DOWN><DOWN><LEFT><RIGHT><LEFT><RIGHT>ba<CR> o _  _____  _   _    _    __  __ ___ <CR><ESC>i\| \|/ / _ \\| \ \| \|  / \  \|  \/  \|_ _\|<CR><ESC>i\| ' / \| \| \|  \\| \| / _ \ \| \|\/\| \|\| \| <CR><ESC>i\| . \ \|_\| \| \|\  \|/ ___ \\| \|  \| \|\| \| <CR><ESC>i\|_\|\_\___/\|_\| \_/_/   \_\_\|  \|_\|___\|<CR><ESC>

" * LEADER MAPS *             {{{2

" leader the easiest key to reach
let mapleader = " "

" switch to last buffer
nnoremap <Leader><Tab> :b#<CR>

" delete buffer, big D to not do it on accident
nnoremap <Leader>D :bd!<CR>

" open vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>V :tabnew $MYVIMRC<CR>

" toggle relativenumber
nnoremap <Leader>n :setlocal rnu! rnu?<CR>

" toggle showing listchars
nnoremap <Leader>l :set list! list?<CR>

" clears search highlights, redraws screen
nnoremap <Leader>/ :nohl<CR><C-l>

" copy and paste from system clipboard
vmap <Leader>y "+y
nmap <Leader>p "+p`]
nmap <Leader>P "+P`]
vmap <Leader>p "+p`]
vmap <Leader>P "+P`]

" toggle highlighting indent columns

let g:indentguides_state = 0 " {{{
function! IndentGuides()
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction
hi def IndentGuides guibg=#303030 ctermbg=234
" }}}
nnoremap <leader>i :call IndentGuides()<cr>

" ** VIM PLUGINS ** (plugin related settings)             {{{1
" ============================================================
"
" If you don't have a certain plugin installed,
" you should remove any corresponding settings

" FileBeagle {{{2
" open specific directory
nnoremap <Leader><C-f> :FileBeagle 

" CtrlP {{{2
" buffer search
nnoremap <Leader>b :CtrlPBuffer<CR>
" specific directory search
nnoremap <Leader><C-p> :CtrlP 

" Tabular {{{2
noremap <Leader>= :Tabularize/

" Gundo {{{2
nnoremap <Leader>u :GundoToggle<CR>

" Tagbar {{{2
nnoremap <Leader>t :TagbarToggle<CR>

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

" vim-airline {{{2
nnoremap <Leader>A :AirlineToggle<CR>
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

