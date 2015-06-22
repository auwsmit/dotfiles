" a vimrc
" Author: Austin Smith <AssailantLF@gmail.com>
" Source: https://github.com/AssailantLF/vimrc

" ===========================================================================
" STARTUP {{{
" ===========================================================================

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

" }}}
" ===========================================================================
" VIM-PLUG {{{
" ===========================================================================
" (minimalist plugin manager)

" Install Vim-Plug at startup if it isn't installed {{{
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
endif

" also enable parallel installer for Windows GVim
if s:running_windows
  let g:plug_threads = 8
endif " }}}

call plug#begin()

" *PRIMARY PLUGINS*
Plug 'tpope/vim-surround'           " surroundings manipulation
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'tpope/vim-unimpaired'         " many helpful mappings
Plug 'tpope/vim-commentary'         " easier commenting
Plug 'tpope/vim-dispatch'           " asynchronous building/testing
Plug 'mhinz/vim-sayonara'           " sane buffer/window closing
Plug 'scrooloose/Syntastic'         " real time error checking
Plug 'kien/CtrlP.vim'               " fuzzy file/buffer search
Plug 'jeetsukumaran/vim-filebeagle' " vinegar inspired file manager
Plug 'junegunn/vim-easy-align'      " text alignment plugin
Plug 'junegunn/goyo.vim'            " distraction free text editing
Plug 'tommcdo/vim-exchange'         " easy text exchange for vim
Plug 'wellle/targets.vim'           " new and improved text objects
Plug 'ajh17/VimCompletesMe'         " simple tab completion
Plug 'ludovicchabant/vim-gutentags' " automatic tag manager
Plug 'majutsushi/Tagbar'            " view ctags easily
if has('python') || has('python3')
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

" }}}
" ===========================================================================
"  GENERAL SETTINGS {{{
" ===========================================================================

set backspace=2      " backspace like most programs in insert mode
set history=1000     " keep x lines of command line history
set hidden           " allow more than one modified buffer
set showcmd          " display incomplete commands
set wildmenu         " visual command-line completion
set wildmode=full    " specifies options for wildmenu
set incsearch        " do incremental searching
set ignorecase       " search isn't case sensitive
set autoread         " auto reload changed files
set vb t_vb=         " plz stop the beeping
set lazyredraw       " redraw the screen less often
set splitright       " open new v-splits to the right
set gdefault         " global :substitute by default
set complete=.,w,b,t " see :help 'complete'
set synmaxcol=400    " don't highlight past 400 characters

" Undo Settings {{{
" save undo history to file
silent! set undofile
" set location to save undo files
let &undodir=expand(g:myvimdir."/undodir")
" create the undo history folder if it doesn't exist
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
" }}}

" disable automatically generated backup files
" livin' on the edge
set nobackup
set nowritebackup
set noswapfile

" use decimal instead of octal with ctrl-a and ctrl-x
set nrformats=

" enable mouse because why not
if has('mouse')
  set mouse=a
endif

" return to the same line when a file is reopened
augroup line_return
  au!
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" ===========================================================================
"  APPEARANCE/AESTHETIC {{{
" ===========================================================================

syntax on        " syntax highlighting
set laststatus=2 " always show status bar
set ruler        " show the cursor position all the time
set guioptions=  " remove extra gui elements
set t_Co=256     " 256 colors, please
set cpoptions+=$ " $ as end marker for the change operator

" fallback default colorscheme
colorscheme desert
" colorscheme of choice
silent! colorscheme badwolf

" set the status line the way Derek Wyatt likes it
" (doesn't work with status line plugins like Lightline)
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

" fonts
if s:running_windows
  set guifont=DejaVu_Sans_Mono:h10
else
  set guifont=DejaVu\ Sans\ Mono\ 10
end

" }}}
" ===========================================================================
" TEXT AND FORMATTING {{{
" ===========================================================================

set encoding=utf-8    " consistent character encoding
set autoindent        " always set autoindenting on
set smartindent       " trying out smartindent for C
set foldmethod=syntax " default fold method
set foldlevel=99      " all folds open initially
set list              " don't show 'listchars' characters
set linebreak         " when wrapping lines, don't break words
set textwidth=80      " always gq format to 80 characters

" how to display certain characters/indicators
set listchars=tab:▸\ ,eol:¬,trail:■,extends:»,precedes:«

augroup persistent_settings
  au!
  " formatting options (see :h fo-table)
  au BufEnter * :set formatoptions=rq1j
augroup END

" don't show trailing spaces in insert mode
augroup trailing
  au!
  au InsertEnter * :set listchars-=trail:■
  au InsertLeave * :set listchars+=trail:■
augroup END

" default indent settings
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab

" indent/format settings for different file types
augroup filetype_specific
  au!
  au FileType vim  :setlocal ts=2 sts=0 sw=2 et fdm=marker fdl=0
  au FileType sh   :setlocal ts=2 sts=0 sw=2 et
  au FileType html :setlocal ts=2 sts=0 sw=2 et
  au FileType c    :setlocal ts=4 sts=0 sw=4 et
  au FileType cpp  :setlocal ts=4 sts=0 sw=4 et
  au FileType make :setlocal ts=8 sts=0 sw=4 noet
augroup END

" }}}
" ===========================================================================
" KEY MAPPINGS + ALIASES {{{
" ===========================================================================
" anything related to plugins is located
" under its respective PLUGIN SETTINGS section

" ---------------------------------------------------------------------------
" REMAPS OF DEFAULTS {{{
" ---------------------------------------------------------------------------

" disabled
noremap  <F1> <NOP>
inoremap <F1> <NOP>

" K for kill window
noremap K <c-W>c

" Y yanks until EOL, more like D and C
" yy still yanks the whole line
nnoremap Y y$

" U as a more sensible redo
nnoremap U <C-r>

" [S]plit line (sister to [J]oin lines)
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>

" qq to record, Q to replay
nnoremap Q @q

" visually select the last paste or change
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" move by wrapped lines instead of line numbers
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" { and } skip over closed folds
nnoremap <expr> } foldclosed(search('^$', 'Wn')) == -1 ? "}" : "}j}"
nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? "{" : "{k{"

" jump to the end of pasted text
" useful for pasting multi-lines of text
xnoremap p p`]
nnoremap p p`]

" esc to stop inserting in Neovim terminal mode
silent! tnoremap <Esc> <C-\><C-n>

" }}}
" ---------------------------------------------------------------------------
" NORMAL MAPS {{{
" ---------------------------------------------------------------------------

" Enter command mode
noremap <CR> :
" | for times when regular <CR> is needed,
" mostly for the command-line window
noremap <Bar> <CR>

" go back to last buffer
noremap <Backspace> <C-^>

" change to current buffer's directory
nmap cd :cd <C-R>=expand("%:p:h")<CR><CR>

" habits
inoremap <C-a>  <Home>
cnoremap <C-a>  <Home>
inoremap <C-e>  <End>
cnoremap <C-e>  <End>

" convenient page scrolling
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" circular windows navigation
nnoremap <Tab>   <c-W>w
nnoremap <S-Tab> <c-W>W

" jump list (previous, next)
nnoremap <C-p> <C-o>zz
nnoremap <C-n> <C-i>zz

" resizing windows
noremap <silent> <C-Left>  :vertical resize -1<CR>
noremap <silent> <C-Up>    :resize   +1<CR>
noremap <silent> <C-Down>  :resize   -1<CR>
noremap <silent> <C-Right> :vertical resize +1<CR>

" panic button
nnoremap <f9> mzggg?G`z

" Go Continuous Scroll-Binding
" This will vertically split the current buffer into two which will stay
" scroll-bound together.  Allows you to see twice as much code at once
" (disables the wrap setting and expands folds to work better)
nnoremap <silent> gcsb :<C-u>let @z=&so<CR>:set so=0 noscb nowrap nofen<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" (go search numbers) search for numbers
nnoremap <silent> g/# /\v\d+<CR>

" run current line as an Ex command
nnoremap g: yy:<C-r>0<BS><CR>

" }}}
" ---------------------------------------------------------------------------
" LEADER MAPS {{{
" ---------------------------------------------------------------------------

" leader the easiest key to reach
let mapleader = "\<Space>"

" open vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>V :tabnew $MYVIMRC<CR>

" quickly manage buffers
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>B :ls<CR>:bd!<Space>

" toggle syntax highlighting
nnoremap <silent> <Leader>s :if exists("g:syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif<CR>

" copy and paste from system clipboard easier
noremap <Leader><Leader> "+

" }}}
" ---------------------------------------------------------------------------
" COMMAND ALIASES {{{
" ---------------------------------------------------------------------------

" expands %% to current file's directory in command-line mode
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

" Clear Trailing White spaces
cabbrev ctw s/\s\+$//e

" delete all buffers
cabbrev bdall 0,999bd!

" }}}
" ---------------------------------------------------------------------------

" }}}
" ===========================================================================
" PLUGIN SETTINGS {{{
" ===========================================================================

" :A command {{{
" Alternate between header and source files.
" (credit to junegunn's vimrc)
function! s:a()
  let name = expand('%:r')
  let ext = tolower(expand('%:e'))
  let sources = ['c', 'cc', 'cpp', 'cxx']
  let headers = ['h', 'hh', 'hpp', 'hxx']
  for pair in [[sources, headers], [headers, sources]]
    let [set1, set2] = pair
    if index(set1, ext) >= 0
      for h in set2
        let aname = name.'.'.h
        for a in [aname, toupper(aname)]
          if filereadable(a)
            execute 'e' a
            return
          end
        endfor
      endfor
    endif
  endfor
endfunction
command! A call s:a()
" }}}

" Fugitive {{{
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gD :Gdiff HEAD<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gl :Git log<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gr :Gremove<CR>
" }}}

" Sayonara {{{
" close buffer
nnoremap gs :Sayonara<CR>
" close buffer, but not window
nnoremap gS :Sayonara!<CR>
" }}}

" CtrlP {{{
" ignore .git folders to speed up searches
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" include hidden files
let g:ctrlp_show_hidden = 1
" change default CtrlP mapping
let g:ctrlp_map = '<Leader>p'
" specific directory search
nnoremap <Leader><C-p> :CtrlP<Space>
" access recent files and buffers
nnoremap <Leader><C-e> :CtrlPMRUFiles<CR>
nnoremap <Leader><C-b> :CtrlPBuffer<CR>
" }}}

" FileBeagle {{{
" show hidden files
let g:filebeagle_show_hidden = 1
" }}}

" Goyo {{{
" toggle Goyo (distraction free editing)
nnoremap <Leader>G :Goyo<CR>
" }}}

" vim-easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" indentLine {{{
nnoremap <Leader>l :IndentLinesToggle<CR>
" }}}

" Gundo {{{
nnoremap <Leader>u :GundoToggle<CR>
" }}}

" Tagbar {{{
nnoremap <Leader>t :TagbarToggle<CR>
" }}}

" UltiSnips {{{
" change default key
" mnemonic: control-snippet
let g:UltiSnipsExpandTrigger="<c-s>"
" }}}

" lightline {{{
" toggle lightline
nnoremap <silent> <Leader>L :exec lightline#toggle()<CR>
" }}}

" Syntastic {{{
" opens errors in the location list
nnoremap <Leader>e :Errors<CR>
" reset Syntastic (clears errors)
nnoremap <Leader>E :SyntasticReset<CR>
" }}}

" Startify {{{
" I use <CR> to enter command mode,
" so use o to open files instead.
autocmd User Startified unmap <buffer> <CR>
autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)
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
" }}}

" }}}
" ===========================================================================
