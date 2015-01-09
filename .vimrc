" vimrc
" Author: Austin Smith <AssailantLF@gmail.com>
" Source: https://github.com/AssailantLF/vimrc

" Organized with folds, try to use them

" ** VIM-PLUG **                                          {{{1
" ============================================================
" (minimalist plugin manager)

" REQUIRED {{{2
" Windows/Linux differences *sigh*
let g:myvimdir ="~/.vim"
if has('win32') || has('win32unix')
  let g:myvimdir ="~/vimfiles"
endif

" don't load plugins if Vim-Plug isn't installed
if filereadable(expand(g:myvimdir . "/autoload/plug.vim"))

call plug#begin()
" }}}

" *CORE PLUGINS*
Plug 'tpope/vim-surround'           " surroundings manipulation
Plug 'tpope/vim-fugitive'           " git integration
Plug 'tpope/vim-unimpaired'         " pairs of handy bracket mappings
Plug 'scrooloose/Syntastic.git'     " real time error checking
Plug 'scrooloose/NERDCommenter'     " intensely pleasant commenting
Plug 'xolox/vim-session'            " extension of default sessions
Plug 'xolox/vim-notes'              " note taking plugin
Plug 'xolox/vim-misc'               " ^session & notes requirement
Plug 'kien/CtrlP.vim'               " fuzzy file/buffer search
Plug 'jeetsukumaran/vim-filebeagle' " vinegar inspired file manager
Plug 'jlanzarotta/bufexplorer'      " buffer explorer/manager
Plug 'godlygeek/Tabular'            " text alignment plugin
Plug 'bkad/CamelCaseMotion'         " movement by CamelCase
Plug 'kurkale6ka/vim-pairs'         " new punctuation text objects
Plug 'tommcdo/vim-exchange'         " easy text exchange for vim
Plug 'majutsushi/Tagbar'            " view ctags easily
if has('python')
  Plug 'sjl/Gundo.vim'              " visual undo tree
  Plug 'SirVer/UltiSnips'           " snippet plugin
  Plug 'honza/vim-snippets'         " preconfigured snippet package
endif

" *AESTHETIC PLUGINS*
Plug 'flazz/vim-colorschemes'       " all the colorschemes
Plug 'AssailantLF/blackwolf'        " my colorscheme
Plug 'bling/vim-airline'            " better looking UI
Plug 'mhinz/vim-Startify'           " nice startup screen
Plug 'edkolev/tmuxline.vim'         " tmux status line
Plug 'Yggdroot/indentLine'          " shows indents made by spaces

" REQUIRED {{{2
" enables filetype detection, ftplugins, and indent files 
filetype plugin indent on

call plug#end()
endif " }}}

" ** GENERAL SETTINGS **                                  {{{1
" ============================================================

" use Vim settings over Vi settings
set nocompatible

set backspace=2          " backspace like most programs in insert mode
set history=1000         " keep x lines of command line history
set browsedir=buffer     " open browser in current buffer directory
set hidden               " allow more than one modified buffer
set showcmd              " display incomplete commands
set wildmenu             " visual command-line completion
set incsearch            " do incremental searching
set ignorecase           " search isn't case sensitive
set autoread             " auto reload changed files
set vb t_vb=             " plz stop the beeping
set foldmethod=marker    " default fold method
set nofoldenable         " disable folds, zi to toggle
set lazyredraw           " redraw only when we need to
set splitright           " open new v-splits to the right

" save undo history
silent! set undofile

" set location to save undo files
let &undodir=expand(g:myvimdir."/undodir")

" create the undo history folder if it doesn't exist
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

" disable automatically generated backup files
" I live on the edge
set nobackup
set nowritebackup
set noswapfile

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

" ** TEXT AND FORMATTING **                               {{{1
" ============================================================

set encoding=utf-8      " consistent character encoding
set formatoptions=roq1j " see :h fo-table
set cpoptions+=$        " $ as end marker for the change operator
set autoindent          " always set autoindenting on
set smartindent         " trying out smartindent for C
set linebreak           " break lines without breaking words
set list                " don't show 'listchars' characters

" how to display certain characters/indicators
set listchars=tab:►\ ,eol:¬,trail:·,extends:>,precedes:<

" highlight 81st column and beyond if reached
highlight colorcolumn ctermbg=DarkRed
highlight colorcolumn guibg=DarkRed
call matchadd('colorcolumn', '\%81v.', 100)

" default tab settings,
" see :h ftplugins for more, because I have
" different preferences depending on file type
set tabstop=2 softtabstop=4 shiftwidth=2 expandtab

" use decimal instead of octal with ctrl-a and ctrl-x
set nrformats=

" ** AESTHETIC/APPEARANCE **                              {{{1
" ============================================================

" default colorscheme
colorscheme desert     " fallback default colorscheme
silent! colorscheme blackwolf


syntax on              " syntax highlighting
set ruler              " show the cursor position all the time
set number             " show line numbers
set laststatus=2       " always show status bar
set scrolloff=5        " keep some lines above & below for scope
set winwidth=80        " minimum width for splits
set winheight=15       " minimum height for splits
set t_Co=256           " allow more colors

" set the status line the way Derek Wyatt likes it
" (doesn't work with status line plugins like Airline)
set stl=%m\ %f\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" gvim specific, who needs a tiny gvimrc?
if has('gui_running')

  " remove the menu, toolbar, and scrollbars
  set guioptions-=m
  set guioptions-=T
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R

  " auto max window and set font, depending on OS
  if has('win32')
    au GUIEnter * simalt ~x
    set guifont=liberation_mono:h11
  else
    set lines=999 columns=999
    set guifont=Liberation\ Mono\ 11
  endif
endif

" resize splits when the window is resized
" change ; to : if there's an error
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

" CTRL-Q for Quit, I never use Ex-mode
noremap <C-q> :quit<CR>

" [S]plit line (sister to [J]oin lines)
" cc still substitutes the line like S would
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>

" Y yanks until EOL, more like D and C
" yy still yanks the whole line
nnoremap Y y$

" quick insert mode navigation
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" up and down arrow keys for half-page scrolling
noremap <Up> <C-u>
noremap <Down> <C-d>

" left and right arrow keys to scroll through buffers
noremap <Left> :bp<CR>
noremap <Right> :bn<CR>

" jump to the end of pasted text
" useful for pasting multi-lines of text
vnoremap p p`]
nnoremap p p`]

" * CONVENIENCE MAPS *       {{{2

" quit all, basically ZQ on all windows
noremap ZA :qa!<CR>

" visually select all
nnoremap vsa ggVG

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

" expands %% to current file's directory in command-line mode.
" only placed under Leader Maps for the below commands
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

" edit files from current file's directory without switching directories
" open in (w)indow (s)plit (v)split or (t)ab
map <Leader>ew ;e %%
map <Leader>es ;sp %%
map <Leader>ev ;vsp %%
map <Leader>et ;tabe %%

" open vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>V :tabnew $MYVIMRC<CR>

" switch to last buffer
nnoremap <Leader><Tab> :b#<CR>

" delete buffer
nnoremap <silent> <Leader>X :bd!<CR>

" delete buffer, but not the split
nnoremap <silent> <Leader>D :b#<CR>:bd!#<CR>

" toggle wrap
nnoremap <Leader>w :setlocal wrap! wrap?<CR>

" toggle relativenumber
nnoremap <Leader>n :setlocal rnu!<CR>

" toggle showing listchars
nnoremap <Leader>l :set list!<CR>

" toggle search highlighting
nnoremap <Leader>/ :set hlsearch! hls?<CR>

" copy and paste from system clipboard easier
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

" Column Scroll-Binding
" This will vertically split the current buffer into two which will stay
" scroll-locked together.  Allows you to see twice as much code at once
" (disables the wrap setting and expands folds to work better)
nnoremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb nowrap nofen<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" * COMMAND ALIASES *       {{{2

" Clear Trailing White spaces
cabbrev ctw s/\s\+$//e

" List To Line
" highlight a list of variables separated by commas
" and run :ltl to split them into their own lines.
cabbrev ltl s/, /, \r/g

" delete all buffers
cabbrev bdall 0,9999bd!

" ** PLUGIN SETTINGS **                                   {{{1
" ============================================================

" Fugitive {{{2
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gD :Gdiff HEAD<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gl :Git log<CR>
nnoremap <Leader>gp :Git push<CR>

" CtrlP {{{2
" include hidden files
let g:ctrlp_show_hidden = 1
" specific directory search
nnoremap <Leader><C-p> :CtrlP 

" quick access to recent files and buffers
nnoremap <Leader><C-e> :CtrlPMRUFiles<CR>
nnoremap <Leader><C-b> :CtrlPBuffer<CR>

" FileBeagle {{{2
" show hidden files
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
let g:session_directory = g:myvimdir.'/session'

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
      \ '                                             ',
      \ '       ___________________________           ',
      \ '      /                           \          ',
      \ '      |     VIM - Vi IMproved     |          ',
      \ '      |        version 7.4        |          ',
      \ '      |  by Bram Moolenaar et al. |          ',
      \ '      \_________   _______________/          ',
      \ '                \ / ^__^                     ',
      \ '                 \\ (oo)\_______             ',
      \ '                    (__)\       )\/\         ',
      \ '                        ||----w |            ',
      \ '                        ||     ||            ',
      \ '                                             ',
      \ ]
