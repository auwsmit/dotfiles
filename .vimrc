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

" NeoBundle setup begin {{{2
if has('vim_starting')
  if has('win32') || has('win32unix')
    set runtimepath+=~/vimfiles/bundle/neobundle.vim/
    call neobundle#begin(expand('~/vimfiles/bundle'))
  else
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#begin(expand('~/.vim/bundle'))
  endif
endif

NeoBundleFetch 'Shougo/neobundle.vim'    " The one.

" *CORE PLUGINS* {{{2
NeoBundle 'tpope/vim-surround'           " surroundings manipulation
NeoBundle 'tpope/vim-fugitive'           " git integration
NeoBundle 'tpope/vim-unimpaired'         " pairs of handy bracket mappings
NeoBundle 'scrooloose/Syntastic.git'     " real time error checking
NeoBundle 'scrooloose/NERDCommenter'     " intensely pleasant commenting
NeoBundle 'xolox/vim-session'            " extension of default sessions
NeoBundle 'xolox/vim-notes'              " note taking plugin
NeoBundle 'xolox/vim-misc'               " ^session & notes requirement
NeoBundle 'kien/CtrlP.vim'               " fuzzy file/buffer search
NeoBundle 'jeetsukumaran/vim-filebeagle' " vinegar inspired file manager
NeoBundle 'jlanzarotta/bufexplorer'      " buffer explorer/manager
NeoBundle 'godlygeek/Tabular'            " text alignment plugin
NeoBundle 'bkad/CamelCaseMotion'         " movement by CamelCase
NeoBundle 'kurkale6ka/vim-pairs'         " new punctuation text objects
NeoBundle 'tommcdo/vim-exchange'         " easy text exchange for vim
NeoBundle 'majutsushi/Tagbar'            " view ctags easily
if has('python')
  NeoBundle 'sjl/Gundo.vim'              " visual undo tree
  NeoBundle 'SirVer/UltiSnips'           " snippet plugin
  NeoBundle 'honza/vim-snippets'         " preconfigured snippet package
endif

" *AESTHETIC PLUGINS* {{{2
NeoBundle 'flazz/vim-colorschemes'       " all the colorschemes
NeoBundle 'AssailantLF/badwolf'          " a colorscheme
"NeoBundle 'bling/vim-airline'            " better looking UI
NeoBundle 'ap/vim-buftabline'            " list buffers like tabs
NeoBundle 'mhinz/vim-Startify'           " nice startup screen
NeoBundle 'edkolev/tmuxline.vim'         " tmux status line
NeoBundle 'Yggdroot/indentLine'          " shows indents made by spaces

" NeoBundle setup end {{{2
call neobundle#end()

" enables filetype detection, ftplugins, and indent files 
filetype plugin indent on

" auto install plugins at startup
NeoBundleCheck

" ** GENERAL **                                           {{{1
" ============================================================

" use Vim settings over Vi settings
set nocompatible

set encoding=utf-8       " consistent character encoding
set backspace=2          " backspace like most programs in insert mode
set history=1000         " keep x lines of command line history
set browsedir=buffer     " open browser in current buffer directory
set formatoptions=croq1j " see :h fo-table
set hidden               " allow more than one modified buffer
set showcmd              " display incomplete commands
set incsearch            " do incremental searching
set ignorecase           " search isn't case sensitive
set autoread             " auto reload changed files
set vb t_vb=             " plz stop the beeping
set foldmethod=marker    " default fold method
set nofoldenable         " disable folds, zi to toggle
set lazyredraw           " redraw only when we need to
set splitright           " open new v-splits to the right

" save undo history to a file
set undofile

" set location to save undo files
set undodir=~/vimfiles/undodir

" create the undo history folder if it doesn't exist
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

" disable automatically generated backup files
" this has yet to become an issue
set nobackup
set nowritebackup
set noswapfile

" use decimal instead of octal with ctrl-a and ctrl-x
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
" (doesn't work with status line plugins like Airline)
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

syntax on              " syntax highlighting
set ruler              " show the cursor position all the time
set number             " show line numbers
set laststatus=2       " always show status bar
set wildmenu           " visual command-line completion
set cpoptions+=$       " $ as end marker for the change operator
set autoindent         " always set autoindenting on
set linebreak          " break lines without breaking words
set list               " show invisible characters
set scrolloff=8        " keep some lines above & below for scope
set winwidth=80        " minimum width for splits
set winheight=15       " minimum height for splits

" Windows/Linux font differences..
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
" see :h ftplugins for more, because I have
" different preferences depending on the file type
set tabstop=2 softtabstop=4 shiftwidth=2 expandtab

" gvim specific, who needs a tiny gvimrc?
if has('gui_running')

  " remove the menu, toolbar, and scrollbars
  set guioptions-=m
  set guioptions-=T
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R

  if has('win32')
    " auto max window (Windows)
    au GUIEnter * simalt ~x

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
noremap ; :
noremap : ;

" swap v and ctrl+v because block mode is better
noremap  v    <C-v>
noremap <C-v>  v

" [S]plit line (sister to [J]oin lines)
" cc still substitutes the line like S would
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>

" Y yanks until EOL, more like D and C
" yy still yanks the whole line
nnoremap Y y$

" swap ^/$ and H/L
" only because I navigate by line more often
" and ^/$ are harder to reach for
nnoremap ^ H
nnoremap $ L
nnoremap H ^
nnoremap L $

" ctrl-a to select all
noremap <C-a> <Esc>ggVG

" ctrl-x to cut to the system clipboard
vnoremap <C-x> "+x

" ctrl-c to copy system clipboard
vnoremap <C-c> "+y

" ctrl-v to paste in insert mode (from system clipboard)
inoremap <C-v> a<Esc>x"+Pa
" also remap ctrl-q for literal inserts
inoremap <C-q> <C-v>

" jump to the end of pasted text
" useful for pasting multi-lines of text
vnoremap y y`]
vnoremap p p`]
nnoremap p p`]

" up and down arrow keys for half-page scrolling
noremap <Up> <C-u>
noremap <Down> <C-d>

" left and right arrow keys to scroll through buffers
noremap <Left> :bp<CR>
noremap <Right> :bn<CR>

" * CONVENIENCE MAPS *       {{{2

" quit all, basically ZQ on all windows
noremap ZA :qa!<CR>

" maps to make handling windows a bit easier {{{
" mostly replaces ctrl+W with comma
"
" creating windows
noremap <silent> ,s :wincmd s<CR>
noremap <silent> ,v :wincmd v<CR>
" navigating between windows
noremap <silent> <C-h> <C-W>h<CR>
noremap <silent> <C-j> <C-W>j<CR>
noremap <silent> <C-k> <C-W>k<CR>
noremap <silent> <C-l> <C-W>l<CR>
noremap <silent> ,p :wincmd p<CR>
" moving windows around
noremap <silent> ,ml <C-W>L
noremap <silent> ,mk <C-W>K
noremap <silent> ,mh <C-W>H
noremap <silent> ,mj <C-W>J
noremap <silent> ,mx <C-W>x
" resizing windows
noremap <silent> ,o     :wincmd o<CR>
noremap <silent> <C-Left>  :vertical resize -10<CR>
noremap <silent> <C-Up>    :resize +10<CR>
noremap <silent> <C-Down>  :resize -10<CR>
noremap <silent> <C-Right> :vertical resize +10<CR>
" closing windows
noremap <silent> ,x :close<CR>
noremap <silent> ,cj :wincmd j<CR>:close<CR>
noremap <silent> ,ck :wincmd k<CR>:close<CR>
noremap <silent> ,ch :wincmd h<CR>:close<CR>
noremap <silent> ,cl :wincmd l<CR>:close<CR>
" }}}

" * LEADER MAPS *             {{{2

" leader the easiest key to reach
let mapleader = " "

" expands %% to current buffer's directory in command-line mode.
" only placed under Leader Maps for the below commands
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" edit files from current file's directory without switching directories
" open in (w)indow (s)plit (v)split or (t)ab
map <Leader>ew ;e %%
map <Leader>es ;sp %%
map <Leader>ev ;vsp %%
map <Leader>et ;tabe %%

" switch to last file, easier to reach than CTRL-^
noremap <Leader><Tab> :e#<CR>

" delete buffer, but not the split
noremap <Leader>D :b#<CR>:bd!#<CR>

" open vimrc
noremap <Leader>v :e $MYVIMRC<CR>
noremap <Leader>V :tabnew $MYVIMRC<CR>

" toggle relativenumber
noremap <Leader>n :setlocal rnu! rnu?<CR>

" toggle showing listchars
noremap <Leader>l :set list! list?<CR>

" toggle search highlighting
noremap <Leader>/ :set hlsearch! hls?<CR>

" copy and paste from system clipboard easier
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

" Column Scroll-Binding
" This will vertically split the current buffer into two which will stay
" scroll-locked together.  Allows you to see twice as much code at once
" (disables the wrap setting and folds after being used)
noremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb nowrap nofen<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" * COMMAND ALIASES *       {{{2

" clear trailing white spaces
cabbrev ctw s/\s\+$//e

" List To Line
" highlight a list of variables separated by commas
" and run :ltl to split them into their own lines.
cabbrev ltl s/, /, \r/g

" delete all buffers
cabbrev bdall 0,9999bd!

" ** VIM PLUGINS SETTINGS **                              {{{1
" ============================================================
"
" If you don't have a certain plugin installed, you
" should remove or disable any corresponding settings

" CtrlP {{{2
" include hidden files
let g:ctrlp_show_hidden = 1
" specific directory search
nnoremap <Leader><C-p> :CtrlP 

" FileBeagle {{{2
" show hidden files by default
let g:filebeagle_show_hidden = 1
" open specific directory
nnoremap <Leader><C-f> :FileBeagle 

" BufExplorer {{{2
let g:bufExplorerDisableDefaultKeyMapping=1
nnoremap <Leader>b :BufExplorer<CR>

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
  let g:session_directory = expand('~/vimfiles/session')
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

" vim-notes {{{2
if has('win32') || has('win32unix')
  let g:notes_directories = ['X:\Cloud\Dropbox\Notes']
else
  let g:notes_directories = ['~/Dropbox/Notes']
endif

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

