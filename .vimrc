" a vimrc
" Author: Austin Smith <AssailantLF@gmail.com>
" Source: https://github.com/AssailantLF/vimrc

" ===========================================================================
" STARTUP {{{
" ===========================================================================

let s:is_cygwin = has('win32unix') || has('win64unix')
let s:is_windows = has('win32') || has('win64')
let s:is_mac = has('gui_macvim') || has('mac')
let g:myvimdir ="~/.vim"
if s:is_windows
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
  if s:is_windows
    sil execute "!curl -kfLo ".expand($userprofile . "\\vimfiles\\autoload\\plug.vim", 1)
          \ ." https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  else
    sil execute "!curl -fLo ".expand(g:myvimdir . "/autoload/plug.vim", 1)
          \ ." https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  endif
  autocmd VimEnter * PlugInstall
endif

" also enable parallel installer for Windows GVim
if s:is_windows
  let g:plug_threads = 8
endif " }}}

call plug#begin()

" *PRIMARY PLUGINS*
Plug 'tpope/vim-surround'           " surroundings manipulation
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'tpope/vim-unimpaired'         " many helpful mappings
Plug 'tpope/vim-commentary'         " easier commenting
Plug 'tpope/vim-speeddating'        " increment dates, times, and more
Plug 'tpope/vim-dispatch'           " asynchronous building/testing
Plug 'tpope/vim-abolish'            " improved search/substitute
Plug 'tpope/vim-repeat'             " . repeat for plugins
Plug 'tpope/vim-eunuch'             " UNIX helper commands
Plug 'tpope/vim-rsi'                " readline style insertion
Plug 'haya14busa/incsearch.vim'     " improved incsearch
Plug 'mhinz/vim-sayonara'           " sane buffer/window closing
Plug 'scrooloose/Syntastic'         " real time error checking
Plug 'kien/CtrlP.vim'               " fuzzy file/buffer search
Plug 'ervandew/supertab'            " tab auto completion
Plug 'jeetsukumaran/vim-filebeagle' " vinegar inspired file manager
Plug 'justinmk/vim-syntax-extra'    " improved C syntax highlighting
Plug 'tommcdo/vim-exchange'         " easy text exchange for vim
Plug 'wellle/targets.vim'           " new and improved text objects
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
Plug 'junegunn/goyo.vim'            " distraction free text editing
Plug 'junegunn/vim-easy-align'      " text alignment plugin

call plug#end()

" }}}
" ===========================================================================
"  GENERAL SETTINGS {{{
" ===========================================================================

set backspace=indent,eol,start
set history=1000
set hidden
set showcmd
set wildmenu
set wildmode=full
set incsearch
set ignorecase
set smartcase
set autoread
set vb t_vb=
set lazyredraw
set splitright
set gdefault
set complete=.,w,b,t
set synmaxcol=400
set nrformats-=octal
silent! set mouse=a

" disable backup/swap files
" livin' on the edge
set nobackup
set nowritebackup
set noswapfile

" set location to save undo files
if has('persistent_undo')
  let &undodir=expand(g:myvimdir."/undodir")
  if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
  endif
  set undofile
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

syntax on
set laststatus=2
set ruler
set guioptions=
set t_Co=256
set cpoptions+=$

" fallback default colorscheme
colorscheme desert
silent! colorscheme badwolf

" set the status line the way Derek Wyatt likes it
" (doesn't work with status line plugins like Lightline)
set stl=%m\ %f\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

augroup appearance
  au!
  if s:is_windows
    " maximize window in windows
    au GUIEnter * simalt ~x
    set guifont=DejaVu_Sans_Mono:h10
  else
    set guifont=DejaVu\ Sans\ Mono\ 10
  endif
  " resize splits when the window is resized
  au VimResized * :wincmd =
augroup END

" }}}
" ===========================================================================
" TEXT AND FORMATTING {{{
" ===========================================================================

set encoding=utf-8
set autoindent
set smartindent
set foldmethod=syntax
set foldlevel=99
set list
set linebreak
set textwidth=80
set nosmarttab
set listchars=tab:▸\ ,eol:¬,trail:■,extends:»,precedes:«
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab

augroup filetype_specific
  au!
  au FileType vim  :setlocal ts=2 sts=0 sw=2 et fdm=marker fdl=0
  au FileType sh   :setlocal ts=2 sts=0 sw=2 et
  au FileType html :setlocal ts=2 sts=0 sw=2 et
  au FileType c    :setlocal ts=4 sts=0 sw=4 et
  au FileType cpp  :setlocal ts=4 sts=0 sw=4 et
  au FileType make :setlocal ts=8 sts=0 sw=4 noet
augroup END

augroup persistent_settings
  au!
  au BufEnter * :set formatoptions=rq1j
augroup END

augroup no_trail_in_insert
  au!
  au InsertEnter * :set listchars-=trail:■
  au InsertLeave * :set listchars+=trail:■
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

" automatically jump to the end of pasted text
" useful for pasting multi-lines of text
xnoremap p p`]
nnoremap p p`]

" esc to stop inserting in Neovim terminal mode
silent! tnoremap <Esc> <C-\><C-n>

" }}}
" ---------------------------------------------------------------------------
" NORMAL MAPS {{{
" ---------------------------------------------------------------------------

" Enter command line mode
noremap <CR> :
" | for times when regular <CR> is needed,
" mostly for the command-line window
noremap <Bar> <CR>

" go back to last buffer
noremap <Backspace> <C-^>

" change to current buffer's directory
nmap cd :cd <C-R>=expand("%:p:h")<CR><CR>

" quickly manage buffers
nnoremap gb :ls<CR>:b<Space>

" circular windows navigation
nnoremap <Tab>   <c-W>w
nnoremap <S-Tab> <c-W>W

" jump list (previous, next)
nnoremap <C-p> <C-o>
nnoremap <C-n> <C-i>

" easier scrolling
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

" resizing windows
noremap <silent> <C-Left>  :vertical resize -1<CR>
noremap <silent> <C-Up>    :resize   +1<CR>
noremap <silent> <C-Down>  :resize   -1<CR>
noremap <silent> <C-Right> :vertical resize +1<CR>

" panic button
nnoremap <f9> mzggg?G`z

" Go Continuous Scroll-Binding
" This will vertically split the current buffer into two which will stay
" scroll-bound together.  Allows you to see twice as much as before.
" (disables the wrap setting and expands folds to work better)
nnoremap <silent> gcsb :<C-u>let @z=&so<CR>:set so=0 noscb nowrap nofen<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" (go search numbers) search for all numbers
nnoremap <silent> g/# /\v\d+<CR>

" quit :help windows with q (mostly from Junegunn's vimrc)
function! s:helptab()
  if &buftype == 'help'
    nnoremap <buffer> q :q<cr>
  endif
endfunction
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt call s:helptab()
augroup END

" source vimscript operator
function! SourceVimscript(type)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @"
  if a:type == 'line'
    silent execute "normal! '[V']y"
  elseif a:type == 'char'
    silent execute "normal! `[v`]y"
  elseif a:type == "visual"
    silent execute "normal! gvy"
  elseif a:type == "currentline"
    silent execute "normal! yy"
  endif
  let @" = substitute(@", '\n\s*\\', '', 'g')
  " source the content
  @"
  let &selection = sel_save
  let @" = reg_save
endfunction
nnoremap <silent> g: :set opfunc=SourceVimscript<CR>g@
vnoremap <silent> g: :<C-U>call SourceVimscript("visual")<CR>
nnoremap <silent> g:: :call SourceVimscript("currentline")<CR>

" }}}
" ---------------------------------------------------------------------------
" LEADER MAPS {{{
" ---------------------------------------------------------------------------

" leader the easiest key to reach
let mapleader = "\<Space>"

" write file
nnoremap <Leader>w :w<CR>

" open vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>V :tabnew $MYVIMRC<CR>

" toggle syntax highlighting
nnoremap <silent> <Leader>s :if exists("g:syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif<CR>

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
nnoremap <Leader>b :CtrlPBuffer<CR>
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
nnoremap <Leader>i :IndentLinesToggle<CR>
" disable by default
let g:indentLine_enabled = 0
" enable for certain filetypes
augroup aindentLine
  au!
  au FileType c   execute 'IndentLinesEnable' | doautocmd indentLine Syntax
  au FileType cpp execute 'IndentLinesEnable' | doautocmd indentLine Syntax
augroup END
" }}}

" incsearch.vim {{{
" default maps
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
" }}}

" Gundo {{{
nnoremap <Leader>u :GundoToggle<CR>
" }}}

" Tagbar {{{
nnoremap <Leader>t :TagbarToggle<CR>
" }}}

" lightline {{{
" toggle lightline
nnoremap <silent> <Leader>l :exec lightline#toggle()<CR>
" }}}

" Syntastic {{{
" opens errors in the location list
nnoremap <Leader>e :Errors<CR>
" reset Syntastic (clears errors)
nnoremap <Leader>r :SyntasticReset<CR>
" }}}

" Startify {{{
" I use <CR> to enter command line mode,
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
