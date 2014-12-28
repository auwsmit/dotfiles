" vimrc
" Author: Austin Smith <AssailantLF@gmail.com>
" Source: https://github.com/AssailantLF/vimrc

" ** HELP ON HELP **                                      {{{1
" ============================================================

" Generally, it's always good to :h[elp] any key mapping,
" setting, function, etc. that you don't understand. Vim has
" very convenient help documentation based on several Vi/Vim
" manuals, and if you take the time to RTFM, you will be
" surprised how quickly you're learning things, and you'll
" wish everything else had similar documentation.

" Beginner video on how to use, navigate, and search for help:
"   http://derekwyatt.org/vim/tutorials/novice/#Help 

" ** NEOBUNDLE ** (less stable, more featured Vundle)     {{{1
" ============================================================

" required begin {{{2
if has('vim_starting')
  if has('win32') || has('win32unix')
    set runtimepath+=$HOME/vimfiles/bundle/neobundle.vim/
  else
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
endif
if has('win32') || has('win32unix')
  call neobundle#begin(expand('$HOME/vimfiles/bundle'))
else
  call neobundle#begin(expand('~/.vim/bundle'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'    " The one.

" *CORE PLUGINS* {{{2
NeoBundle 'tpope/vim-surround'           " surroundings manipulation
NeoBundle 'tpope/vim-unimpaired'         " pairs of handy bracket mappings
NeoBundle 'tpope/vim-fugitive'           " git integration
NeoBundle 'scrooloose/Syntastic.git'     " real time error checking
NeoBundle 'scrooloose/NERDCommenter'     " intensely pleasant commenting
NeoBundle 'xolox/vim-session'            " extension of default sessions
NeoBundle 'xolox/vim-misc'               " ^session requirement
NeoBundle 'jeetsukumaran/vim-filebeagle' " vinegar inspired file manager
NeoBundle 'kien/CtrlP.vim'               " fuzzy file search
NeoBundle 'godlygeek/Tabular'            " text alignment plugin
NeoBundle 'tommcdo/vim-exchange'         " easy text exchange for vim
NeoBundle 'majutsushi/Tagbar'            " view ctags easily
if has('python')
  NeoBundle 'sjl/Gundo.vim'              " visual undo tree
  NeoBundle 'SirVer/UltiSnips'           " snippet plugin
  NeoBundle 'honza/vim-snippets'         " preconfigured snippet package
endif

" *NEW/EXPERIMENTAL* {{{2
"NeoBundle 'vim-scripts/EnhancedJumps'    " extension of default jumps
NeoBundle 'bkad/CamelCaseMotion'         " movement by camel case

" *AESTHETIC PLUGINS* {{{2
NeoBundle 'flazz/vim-colorschemes'       " all the colorschemes
NeoBundle 'AssailantLF/badwolf'          " a colorscheme
NeoBundle 'fmoralesc/molokayo'           " a colorscheme
NeoBundle 'bling/vim-airline'            " better looking UI
NeoBundle 'mhinz/vim-Startify'           " nice startup screen
NeoBundle 'edkolev/tmuxline.vim'         " tmux status line
NeoBundle 'Yggdroot/indentLine'          " shows indents made by spaces

" required end {{{2
call neobundle#end()
filetype plugin indent on

" auto install plugins at startup
NeoBundleCheck

" ** GENERAL **                                           {{{1
" ============================================================

" use Vim settings over Vi settings
set nocompatible

set encoding=utf-8       " consistent character encoding
set backspace=2          " backspace like most programs in insert mode
set history=200          " keep x lines of command line history
set browsedir=buffer     " open browser in current buffer directory
set formatoptions=croq1j " see :h fo-table
set hidden               " allow more than one modified buffer
set showcmd              " display incomplete commands
set incsearch            " do incremental searching
set autoread             " auto reload changed files
set vb t_vb=             " plz stop the beeping
set foldmethod=marker    " default fold method
set nofoldenable         " disable folds, zi to toggle
set lazyredraw           " redraw only when we need to
set splitright           " open new v-splits to the right
set nobackup             " I live on the edge breh
set nowritebackup
set noswapfile

" use decimal instead of octal with ctrl+a and ctrl+x
set nrformats=

" enable mouse because why not
if has('mouse')
  set mouse=a
endif

" returns to the same line when you reopen a file
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" ** APPEARANCE **                                        {{{1
" ============================================================

" 256 color terminal, helps with terminal colorschemes
if has('unix')
  set t_Co=256
endif

" vim colorscheme
colorscheme desert     " fallback default colorscheme
colorscheme blackwolf

" set the status line the way Derek Wyatt likes it
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

syntax on              " syntax highlighting
set ruler              " show the cursor position all the time
set number             " show line numbers
set laststatus=2       " always show status bar
set guioptions-=T      " no toolbar, it's ugly
set wildmenu           " better command-line completion
set cpoptions+=$       " $ as end marker for the change operator
set autoindent         " always set autoindenting on
set linebreak          " break lines without breaking words
set list               " show invisible characters
set scrolloff=8        " keep some lines above & below for scope

" Windows/Linux differences..
if has('win32') || has('win32unix')
  set listchars=tab:\|-,eol:¬,trail:·,extends:>,precedes:<
else
  set listchars=tab:▸\ ,eol:¬,trail:·,extends:❯,precedes:❮
endif

" highlight 81st column and beyond if reached,
" sometimes doesn't work well with gvim,
" see (:h ctermbg) if darkred doesn't fit with your colorscheme
highlight colorcolumn ctermbg=DarkRed
call matchadd('colorcolumn', '\%81v.', 100)

" default tab settings,
" see :h ftplugins for more
set tabstop=2 softtabstop=4 shiftwidth=2 expandtab

" gvim specific
if has('gui_running')
  if has('win32')
    " auto max window (Windows)
    au GUIEnter * simalt ~x
    " set font
    set guifont=liberation_mono:h11
  else
    " auto max window
    set lines=999 columns=999
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

" up and down arrow keys for scrolling
nnoremap <Up> <C-u>
nnoremap <Down> <C-d>

" left and right arrow keys scroll through buffers
nnoremap <Left> :bp<CR>
nnoremap <Right> :bn<CR>

" swap (^/$) and (H/L)
"
" only because I navigate by line more often
" and ^/$ are harder to reach for
nnoremap ^ H
nnoremap $ L
nnoremap H ^
nnoremap L $

" [S]plit line (sister to [J]oin lines)
" cc still substitutes the line like S would
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>

" Y yanks until EOL, more like D and C
" yy still yanks the whole line
nnoremap Y y$

" ctrl-c to copy system clipboard, because habits
vnoremap <C-c> "+y

" ctrl-v to paste in insert mode (from system clipboard)
inoremap <C-v> a<Esc>x"+pa
" also remap ctrl-l for literal inserts
inoremap <C-l> <C-v>

" jump to the end of pasted text
" useful for pasting multi-lines of text
vnoremap y y`]
vnoremap p p`]
nnoremap p p`]

" * CONVENIENCE MAPS *       {{{2

" quick insert-mode escape
inoremap jk <Esc>
inoremap jj <Esc>

" select all text
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

" * LEADER MAPS *             {{{2

" leader the easiest key to reach
let mapleader = " "

" switch to last buffer
nnoremap <Leader><Tab> :b#<CR>

" delete buffer, big D to not do it on accident
" won't delete the split like it normally does
nnoremap <Leader>D :bp<BAR>bd! #<CR>

" open vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>V :tabnew $MYVIMRC<CR>

" toggle relativenumber
nnoremap <Leader>n :setlocal rnu! rnu?<CR>

" toggle showing listchars
nnoremap <Leader>l :set list! list?<CR>

" toggle search highlighting
nnoremap <Leader>/ :set hlsearch! hls?<CR>

" copy and paste from system clipboard easier
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Column Scroll-Binding
" This will vertically split the current buffer
" into two which will stay scroll-locked together.
" Allows you to see twice as much code at once
" (disables wrap and folds after being used)
noremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb nowrap nofen<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

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
nnoremap <leader>i :call IndentGuides()<CR>

" * COMMAND ALIASES *       {{{2

" clear trailing white spaces
cabbrev ctw s/\s\+$//e

" List To Line
" highlight a list of variables separated by commas
" and run :ltl to split them into their own lines.
cabbrev ltl s/, /, \r/g

" current buffer's directory
cabbrev cbdir %:p:h

" delete all buffers
cabbrev bdall 0,9999bd!

" ** VIM PLUGINS SETTINGS **                              {{{1
" ============================================================
"
" If you don't have a certain plugin installed, you
" should remove or disable any corresponding settings

" FileBeagle {{{2
" show hidden files by default
let g:filebeagle_show_hidden = 1
" open specific directory
nnoremap <Leader><C-f> :FileBeagle 

" CtrlP {{{2
" include dotfiles/directories in search
let g:ctrlp_show_hidden = 1
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
if has('win32') || has('win32unix')
  let g:session_directory = expand('$HOME/vimfiles/session')
else
  let g:session_directory = '~/.vim/session'
endif

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
      \ '__/\\\________/\\\___________________________        ',
      \ ' _\/\\\_______\/\\\___________________________       ',
      \ '  _\//\\\______/\\\___/\\\_____________________      ',
      \ '   __\//\\\____/\\\___\///_____/\\\\\__/\\\\\___     ',
      \ '    ___\//\\\__/\\\_____/\\\__/\\\///\\\\\///\\\_    ',
      \ '     ____\//\\\/\\\_____\/\\\_\/\\\_\//\\\__\/\\\_   ',
      \ '      _____\//\\\\\______\/\\\_\/\\\__\/\\\__\/\\\_  ',
      \ '       ______\//\\\_______\/\\\_\/\\\__\/\\\__\/\\\_ ',
      \ '        _______\///________\///__\///___\///___\///__',
      \ '',
      \ '',
      \ ]

