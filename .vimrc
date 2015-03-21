" vimrc
" Author: Austin Smith <AssailantLF@gmail.com>
" Source: https://github.com/AssailantLF/vimrc

" Organized with folds, try to use them

" ** STARTUP **                                           {{{1
" ============================================================

" Windows/Linux differences
let s:running_windows = has("win16") || has("win32") || has("win64")
let g:myvimdir ="~/.vim"
if s:running_windows
  let g:myvimdir ="~/vimfiles"
endif

" use Vim settings over Vi settings
set nocompatible

" enables filetype detection, ftplugins, and indent files
filetype plugin indent on

" ** VIM-PLUG **                                          {{{1
" ============================================================
" (minimalist plugin manager)

" Install Vim-Plug at startup if it isn't installed {{{2
" (Windows needs curl, Linux needs curl or wget)
if !filereadable(expand(g:myvimdir . "/autoload/plug.vim"))
  echo "Installing Vim-Plug and plugins,"
  echo "restart Vim to finish installation."
  silent call mkdir(expand(g:myvimdir . "/autoload", 1), 'p')
  if s:running_windows
    sil execute "!curl -kfLo ".expand($userprofile . "\\vimfiles\\autoload\\plug.vim", 1)
          \ ." https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  else
    sil execute "!wget -nc -q github.com/junegunn/vim-plug/raw/master/plug.vim -P "
          \ .expand(g:myvimdir . "/autoload/", 1)
    sil execute "!curl -fLo ".expand(g:myvimdir . "/autoload/plug.vim", 1)
          \ ." https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  endif
  autocmd VimEnter * PlugInstall
endif " }}}

call plug#begin()

" *PRIMARY PLUGINS*
Plug 'tpope/vim-surround'           " surroundings manipulation
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'tpope/vim-unimpaired'         " pairs of handy bracket mappings
Plug 'tpope/vim-commentary'         " easier commenting
Plug 'scrooloose/Syntastic'         " real time error checking
Plug 'kien/CtrlP.vim'               " fuzzy file/buffer search
Plug 'jeetsukumaran/vim-filebeagle' " vinegar inspired file manager
Plug 'godlygeek/Tabular'            " text alignment plugin
Plug 'bkad/CamelCaseMotion'         " movement by CamelCase
Plug 'justinmk/vim-sneak'           " medium-range motion for s/S
Plug 'tommcdo/vim-exchange'         " easy text exchange for vim
Plug 'ludovicchabant/vim-gutentags' " automatic tag manager
Plug 'majutsushi/Tagbar'            " view ctags easily
if has('python')
  Plug 'sjl/Gundo.vim'              " visual undo tree
  Plug 'SirVer/UltiSnips'           " snippet plugin
  Plug 'honza/vim-snippets'         " preconfigured snippet package
endif

" *AESTHETIC PLUGINS*
Plug 'flazz/vim-colorschemes'       " all the colorschemes
Plug 'itchyny/lightline.vim'        " better looking UI
Plug 'mhinz/vim-Startify'           " nice startup screen
Plug 'Yggdroot/indentLine'          " shows indents made of spaces

call plug#end()

" ** GENERAL SETTINGS **                                  {{{1
" ============================================================

set backspace=2       " backspace like most programs in insert mode
set history=1000      " keep x lines of command line history
set hidden            " allow more than one modified buffer
set showcmd           " display incomplete commands
set wildmenu          " visual command-line completion
set incsearch         " do incremental searching
set ignorecase        " search isn't case sensitive
set autoread          " auto reload changed files
set vb t_vb=          " plz stop the beeping
set lazyredraw        " redraw only when we need to
set splitright        " open new v-splits to the right
set gdefault          " global substitute by default
set complete=.,w,b,t  " see :help 'complete'

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

" ** APPEARANCE/UI **                                     {{{1
" ============================================================

syntax on             " syntax highlighting
set laststatus=2      " always show status bar
set ruler             " show the cursor position all the time
set number            " show line numbers
set scrolloff=5       " keep some lines above & below for scope
set guioptions=       " remove extra gui elements
set t_Co=256          " 256 colors, please

" fallback default colorscheme
colorscheme desert
" colorscheme of choice
silent! colorscheme badwolf

" set the status line the way Derek Wyatt likes it
" (doesn't work with status line plugins like Airline)
set stl=%m\ %f\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" maximize window, doesn't always work
" with terminal vim and some Linux distros
if s:running_windows
  au GUIEnter * simalt ~x
else
  call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)
endif

" resize splits when the window is resized
au VimResized * :wincmd =

" ** TEXT AND FORMATTING **                               {{{1
" ============================================================

set encoding=utf-8    " consistent character encoding
set cpoptions+=$      " $ as end marker for the change operator
set autoindent        " always set autoindenting on
set smartindent       " trying out smartindent for C
set foldmethod=syntax " default fold method
set nofoldenable      " all folds open initially
set list              " don't show 'listchars' characters
set linebreak         " when wrapping lines, don't break words
set textwidth=80      " always gq to 80 characters

augroup persistent_settings
  au!
  " formatting options (see :h fo-table)
  au BufEnter * :set formatoptions=rq1j
augroup END

" how to display certain characters/indicators
set listchars=tab:▸\ ,eol:¬,trail:·,extends:>,precedes:<

" don't show trailing spaces in insert mode
augroup trailing
  au!
  au InsertEnter * :set listchars-=trail:·
  au InsertLeave * :set listchars+=trail:·
augroup END

" default tab settings
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab

augroup filetype_specific_format
  au!
  au FileType vim  :setlocal ts=2 sts=0 sw=2 et fdm=marker
  au FileType sh   :setlocal ts=2 sts=0 sw=2 et
  au FileType html :setlocal ts=2 sts=0 sw=2 et
  au FileType c    :setlocal ts=4 sts=0 sw=4 et
  au FileType cpp  :setlocal ts=4 sts=0 sw=4 et
  au FileType make :setlocal ts=4 sts=0 sw=4 noet
augroup END

" use decimal instead of octal with ctrl-a and ctrl-x
set nrformats=

" fonts
if s:running_windows
  set guifont=DejaVu_Sans_Mono:h10
else
  set guifont=DejaVu\ Sans\ Mono\ 10
end

" ** KEY MAPPINGS/ALIASES **                                 {{{1
" ============================================================
"
" anything related to plugins is located
" under its respective vim plugins section

" * REMAPS OF DEFAULTS *      {{{2

" disabled
noremap <F1> <NOP>
inoremap <F1> <NOP>
noremap ZQ <NOP>

" Enter command mode
noremap <CR> :
noremap <S-CR> <CR>

" go back to last buffer
noremap <Backspace> :b#<CR>

" K for Kill window
noremap K <c-W>c

" Y yanks until EOL, more like D and C
" yy still yanks the whole line
nnoremap Y y$

" U as a more sensible redo
nnoremap U <C-r>

" this is because ^/$ are hard to reach,
" and I never use normal H/L anyway
noremap H ^
noremap L $

" go [s]plit line (sister to [J]oin lines)
nnoremap gs i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>

" visually select the last paste or change
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" move by wrapped lines instead of line numbers
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" replace - with _ to make it more consistent with +
noremap _ -

" { and } skip over closed folds
nnoremap <expr> } foldclosed(search('^$', 'Wn')) == -1 ? "}" : "}j}"
nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? "{" : "{k{"

" jump to the end of pasted text
" useful for pasting multi-lines of text
vnoremap p p`]
nnoremap p p`]

" * CONVENIENCE MAPS *       {{{2

" habits
nnoremap <silent> <C-s> :update<CR>
inoremap <C-BS> <C-w>
cnoremap <C-BS> <C-w>
inoremap <C-a> <Esc>I
cnoremap <C-a> <Home>
inoremap <C-e> <Esc>A
cnoremap <C-e> <End>

" visually select all
nnoremap vaa ggVG

" change to current buffer's directory
map <silent> cd :cd <C-R>=expand("%:p:h")<CR><CR>

" navigating between windows
noremap <silent> <C-h> <C-w>h<CR>
noremap <silent> <C-j> <C-w>j<CR>
noremap <silent> <C-k> <C-w>k<CR>
noremap <silent> <C-l> <C-w>l<CR>

" resizing windows
noremap <silent> <C-Left>  :vertical resize -3<CR>
noremap <silent> <C-Up>    :resize +2<CR>
noremap <silent> <C-Down>  :resize -2<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>

" Go Continuous Scroll-Binding
" This will vertically split the current buffer into two which will stay
" scroll-bound together.  Allows you to see twice as much code at once
" (disables the wrap setting and expands folds to work better)
nnoremap <silent> gcsb :<C-u>let @z=&so<CR>:set so=0 noscb nowrap nofen<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" * LEADER MAPS *             {{{2

" leader the easiest key to reach
let mapleader = "\<Space>"

" open vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>V :tabnew $MYVIMRC<CR>

" quickly manage buffers
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>B :ls!<CR>:b<Space>

" toggle syntax highlighting
nnoremap <Leader>s :if exists("g:syntax_on") <BAR> syntax off <BAR> else <BAR> syntax enable <BAR> endif<CR>

" delete buffer
nnoremap <silent> <Leader>X :bd!<CR>

" delete buffer, but not split/window
nnoremap <silent> <Leader>D :bn<CR>:bd!#<CR>

" toggle syntax highlighting
nnoremap <silent> <Leader>s :if exists("g:syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif<CR>

" copy and paste from system clipboard easier
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p d"+P

" * COMMAND ALIASES *       {{{2

" expands %% to current file's directory in command-line mode
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

" Clear Trailing White spaces
cabbrev ctw s/\s\+$//e

" delete all buffers
cabbrev bdall 0,9999bd!

" ** PLUGIN SETTINGS **                                   {{{1
" ============================================================

" Only load these settings if Vim-Plug seems to be installed
if filereadable(expand(g:myvimdir . "/autoload/plug.vim"))

  " Fugitive {{{2
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <Leader>gd :Gdiff<CR>
  nnoremap <Leader>gD :Gdiff HEAD<CR>
  nnoremap <Leader>gc :Gcommit<CR>
  nnoremap <Leader>gl :!git log<CR>
  nnoremap <Leader>gp :Git push<CR>
  nnoremap <Leader>gw :Gwrite<CR>
  nnoremap <Leader>gr :Gremove<CR>

  " CtrlP {{{2
  " ignore .git folders to speed up searches
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
  " include hidden files
  let g:ctrlp_show_hidden = 1
  " specific directory search
  nnoremap <Leader><C-p> :CtrlP<Space>
  " quick access to recent files and buffers
  nnoremap <Leader><C-e> :CtrlPMRUFiles<CR>
  nnoremap <Leader><C-b> :CtrlPBuffer<CR>

  " FileBeagle {{{2
  " show hidden files
  let g:filebeagle_show_hidden = 1

  " Tabular {{{2
  noremap <Leader>= :Tabularize/

  " Gundo {{{2
  nnoremap <Leader>u :GundoToggle<CR>

  " Tagbar {{{2
  nnoremap <Leader>t :TagbarToggle<CR>

  " CamelCaseMotion {{{2
  " remap prefix to \ instead of ,
  map <silent> \w <Plug>CamelCaseMotion_w
  map <silent> \b <Plug>CamelCaseMotion_b
  map <silent> \e <Plug>CamelCaseMotion_e

  " lightline {{{2
  " toggle lightline
  nnoremap <silent> <Leader>L :exec lightline#toggle()<CR>

  " Syntastic {{{2
  " reset Syntastic (clears errors)
  nnoremap <Leader>S :SyntasticReset<CR>

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

endif
