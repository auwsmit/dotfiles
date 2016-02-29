" a vimrc
" Author: Austin Smith <AssailantLF@gmail.com>
" Source: https://gitlab.com/AssailantLF/vimrc

" ===========================================================================
" STARTUP {{{
" ===========================================================================

" let s:is_cygwin = has('win32unix') || has('win64unix')
" let s:is_mac = has('gui_macvim') || has('mac')
let s:is_windows = has('win32') || has('win64')
let s:is_nvim = has('nvim')
let s:myvimdir ="~/.vim"
if s:is_windows
  let s:myvimdir ="~/vimfiles"
endif
if s:is_nvim
  let s:myvimdir ="~/.config"
endif

" use Vim settings over obsolescent Vi settings
set nocompatible

" enables filetype detection, ftplugins, and indent files
filetype plugin indent on

" }}}
" ===========================================================================
" VIM-PLUG {{{
" ===========================================================================
" (minimalist plugin manager)

" Install Vim-Plug at startup if it isn't installed {{{

if !filereadable(expand(s:myvimdir . "/autoload/plug.vim"))
  echo "Installing Vim-Plug and plugins,"
  echo "restart Vim to finish installation."
  silent! call mkdir(expand(s:myvimdir . "/autoload"), 'p')
  silent! execute "!curl -fLo ".expand(s:myvimdir . "/autoload/plug.vim")
        \ ." https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  au VimEnter * PlugInstall
endif

" }}}

call plug#begin()

" PLUGINS

" Tim Pope
Plug 'tpope/vim-surround'           " surroundings manipulation
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'tpope/vim-unimpaired'         " many helpful mappings
Plug 'tpope/vim-commentary'         " easier commenting
Plug 'tpope/vim-speeddating'        " increment dates, times, and more
Plug 'tpope/vim-repeat'             " . repeat for plugins
Plug 'tpope/vim-eunuch'             " UNIX helper commands
Plug 'tpope/vim-rsi'                " readline style insertion
Plug 'tpope/vim-dispatch'           " asynchronous make

" Text Objects
Plug 'kana/vim-textobj-user'        " custom text object plugin
Plug 'kana/vim-textobj-entire'      " entire document (ae)
Plug 'kana/vim-textobj-indent'      " indent (ai)
Plug 'glts/vim-textobj-comment'     " comment (ac)
Plug 'kana/vim-textobj-function'    " function (af)
Plug 'wellle/targets.vim'           " more extra text objects

" Appearance/UI
Plug 'justinmk/vim-syntax-extra'    " improved C syntax highlighting
Plug 'flazz/vim-colorschemes'       " all the colorschemes
Plug 'itchyny/lightline.vim'        " better looking UI
Plug 'mhinz/vim-Startify'           " nice startup screen
Plug 'Yggdroot/indentLine'          " shows indents made of spaces
Plug 'junegunn/vim-easy-align'      " text alignment plugin
Plug 'junegunn/goyo.vim'            " distraction free text editing
Plug 'kkoenig/wimproved.vim'        " improvements for Windows UI

" The Rest
Plug 'jeetsukumaran/vim-filebeagle' " vinegar inspired file manager
Plug 'tommcdo/vim-exchange'         " easy text exchange for vim
Plug 'Konfekt/FastFold'             " more efficient automatic folding
Plug 'mhinz/vim-sayonara'           " sane buffer/window closing
Plug 'scrooloose/Syntastic'         " real time error checking
Plug 'ctrlpvim/ctrlp.vim'           " fuzzy file/buffer search
Plug 'ervandew/supertab'            " tab auto completion
Plug 'AndrewRadev/switch.vim'       " toggle/switch various objects
Plug 'szw/vim-g'                    " google search from Vim
Plug 'ludovicchabant/vim-gutentags' " automatic tag manager
Plug 'majutsushi/Tagbar'            " view ctags easily
if has('python') || has('python3')
  Plug 'sjl/Gundo.vim'              " visual undo tree
  Plug 'SirVer/UltiSnips'           " snippet plugin
  Plug 'honza/vim-snippets'         " preconfigured snippet package
endif

call plug#end()

" }}}
" ===========================================================================
"  GENERAL SETTINGS {{{
" ===========================================================================

set hidden
set incsearch
set ignorecase
set smartcase
set autoread
set lazyredraw
set gdefault
set showcmd
set vb t_vb=
set backspace=indent,eol,start
set history=10000
set undolevels=100000
set complete=.,w,b,t
set synmaxcol=256
set nrformats-=octal
set fileformat=unix
set virtualedit=all
set sessionoptions-=options
if s:is_windows
  set makeprg=build.bat
endif
silent! set mouse=a

" command-line completion settings
set wildmenu
set wildmode=full
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

" disable backup/swap files
set nobackup
set nowritebackup
set noswapfile

" set location to save undo files
if has('persistent_undo')
  let &undodir=expand(s:myvimdir."/undodir")
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
set cursorline
set guioptions=
set t_Co=256
set cpoptions+=$
set splitright
set numberwidth=1

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
    set guifont=DejaVu_Sans_Mono:h9
  else
    set guifont=DejaVu\ Sans\ Mono\ 9
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
set textwidth=80
set nosmarttab
set linebreak
set listchars=tab:▸\ ,trail:■,extends:»,precedes:«
set list
if has('linebreak')
  set showbreak=+↪
  silent! set breakindent
else
  set listchars+=eol:¬
endif

set tabstop=4 softtabstop=0 shiftwidth=4 expandtab

augroup filetype_specific
  au!
  au FileType vim  :setlocal ts=2 sts=2 sw=2 et fdm=marker fdl=0
  au FileType sh   :setlocal ts=2 sts=2 sw=2 et
  au FileType html :setlocal ts=2 sts=2 sw=2 et
  au FileType c    :setlocal ts=4 sts=4 sw=4 et cino=(0)
  au FileType cpp  :setlocal ts=4 sts=4 sw=4 et cino=(0)
  au FileType make :setlocal ts=8 sts=8 sw=4 noet
augroup END

augroup persistent_formatoptions
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

" Enter command line mode
noremap <cr> :
" make Enter/CR work normally in quickfix and command-window
augroup enter_correctly
  au!
  au BufReadPost quickfix nnoremap <buffer> <cr> <cr>
  au CmdWinEnter * nnoremap <buffer> <cr> <cr>
augroup END

" K for kill window
noremap K <c-w>c

" Y yanks until EOL, more like D and C
" yy still yanks the whole line
nnoremap Y y$

" U as a more sensible redo
nnoremap U <c-r>

" [S]plit line (sister to [J]oin lines)
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>$

" format the last paste or change
nnoremap g= `[v`]=

" move by wrapped lines instead of line numbers, unless the motion is counted
noremap <expr> j (v:count? 'j' : 'gj')
noremap <expr> k (v:count? 'k' : 'gk')

" { and } skip over closed folds
nnoremap <expr> } foldclosed(search('^$', 'Wn')) == -1 ? "}" : "}j}"
nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? "{" : "{k{"

" automatically jump to the end of pasted text
" useful for pasting multi-lines of text
xnoremap p p`]
nnoremap p p`]

" esc to stop inserting in Neovim terminal mode
if s:is_nvim
  tnoremap <Esc><Esc> <c-\><c-n>
endif

" }}}
" ---------------------------------------------------------------------------
" NORMAL MAPS {{{
" ---------------------------------------------------------------------------

" expand-o-brackets
inoremap {<tab> {<cr>}<esc>O

" go back to last buffer
noremap <backspace> <c-^>

" change to current buffer's directory
nnoremap cd :cd <c-r>=expand("%:p:h")<cr><cr>

" quickly manage buffers
nnoremap gb :ls<cr>:b<space>

" alternate K since it's remapped
nnoremap gK K

" jump list (previous, next)
" (this mapping allows <tab> to be used separately,
" since <tab> and <c-i> are linked in Normal mode)
nnoremap <c-p> <c-o>
nnoremap <c-n> <c-i>

" circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <s-tab> <c-w>W

" easier scrolling (I just prefer not reaching for e and y)
nnoremap <c-j> <c-e>
nnoremap <c-k> <c-y>

" resizing windows/splits
noremap <c-left>  <c-w><
noremap <c-up>    <c-w>+
noremap <c-down>  <c-w>-
noremap <c-right> <c-w>>

" (go search numbers) search for all numbers
nnoremap <silent> g/# /\v\d+<cr>

" panic button (mostly a novelty)
nnoremap <f9> mzggg?G`z

" Go Continuous Scroll-Binding
" This will vertically split the current buffer into two which will stay
" scroll-bound together.  Allows you to see twice as much as before.
" (disables the wrap setting and expands folds to work better)
" (PS: this is kind of janky, but I like it anyway)
nnoremap <silent> gcsb :<c-u>let @z=&so<cr>:set so=0 noscb nowrap nofen<cr>:bo vs<cr>Ljzt:setl scb<cr><c-w>p:setl scb<cr>:let &so=@z<cr>

" }}}
" ---------------------------------------------------------------------------
" LEADER MAPS {{{
" ---------------------------------------------------------------------------

" leader the easiest key to reach
let mapleader = "\<space>"

" write file
nnoremap <leader>w :w<cr>

" open vimrc
nnoremap <leader>v :e $MYVIMRC<cr>
nnoremap <leader>V :tabnew $MYVIMRC<cr>

" toggle syntax highlighting {{{
function! ToggleSyntaxHightlighting()
  if exists("g:syntax_on")
    syntax off
  else
    syntax on
  endif
endfunction
" }}}
nnoremap <silent> <leader>S :call ToggleSyntaxHightlighting()<cr>

" toggle location & quickfix lists {{{
" (from vimwiki)
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction
" }}}
nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<cr>
nnoremap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<cr>

" }}}
" ---------------------------------------------------------------------------
" COMMAND ALIASES {{{
" ---------------------------------------------------------------------------

" expands %% to current file's directory in command-line mode
cnoremap %% <c-r>=fnameescape(expand('%:h')).'/'<cr>

" Clear Trailing White spaces
cabbrev ctw s/\s\+$//e

" delete all buffers
cabbrev bdall 0,999bd!

" }}}
" ---------------------------------------------------------------------------

" }}}
" ===========================================================================
" MINI PLUGINS {{{
" ===========================================================================

" q to quit help {{{
" (mostly from Junegunn's vimrc)
function! s:helpquit()
  if &buftype == 'help'
    nnoremap <buffer> q :bd<cr>
  endif
endfunction
augroup q_for_quit
  au!
  au BufEnter *.txt call s:helpquit()
augroup END
" }}}

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

" Source vimscript operator {{{
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
nnoremap <silent> g: :set opfunc=SourceVimscript<cr>g@
vnoremap <silent> g: :<c-U>call SourceVimscript("visual")<cr>
nnoremap <silent> g:: :call SourceVimscript("currentline")<cr>
" }}}

" }}}
" ===========================================================================
" PLUGIN SETTINGS {{{
" ===========================================================================

" Fugitive {{{
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gD :Gdiff HEAD<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gr :Gremove<cr>
" }}}

" Dispatch {{{
nnoremap <leader>m :Make<cr>
" }}}

" Sayonara {{{
" close buffer
nnoremap gs :Sayonara<cr>
" close buffer, but not window
nnoremap gS :Sayonara!<cr>
" }}}

" CtrlP {{{
" ignore .git folders to speed up searches
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_max_depth = 15
let g:ctrlp_max_files = 30000
" include hidden files
let g:ctrlp_show_hidden = 1
" open multiple files in ONE window
let g:ctrlp_open_multiple_files = '1vr'
" change default CtrlP mapping
" more like LeaderP amirite
let g:ctrlp_map = '<leader>p'
" specific directory search
nnoremap <leader><c-p> :CtrlP<space>
" access recent files and buffers
nnoremap <leader><c-e> :CtrlPMRUFiles<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
" }}}

" FileBeagle {{{
" show hidden files
let g:filebeagle_show_hidden = 1
" }}}

" wimproved.vim {{{
" toggle fullscreen
nnoremap <F11> :WToggleFullscreen<CR>
augroup wimproved
  autocmd GUIEnter * silent! WToggleClean
augroup END
" }}}

" Goyo {{{
" toggle Goyo (distraction free editing)
nnoremap <leader>G :Goyo<cr>
" }}}

" vim-easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" indentLine {{{
nnoremap <leader>i :IndentLinesToggle<cr>
" disable by default
let g:indentLine_enabled = 0
" enable for certain filetypes
augroup aindentLine
  au!
  au FileType c   execute 'IndentLinesEnable' | doau indentLine Syntax
  au FileType cpp execute 'IndentLinesEnable' | doau indentLine Syntax
augroup END
" }}}

" switch.vim {{{
let g:switch_mapping = "<leader>s"
"}}}

" Gundo {{{
nnoremap <leader>u :GundoToggle<cr>
" }}}

" Tagbar {{{
nnoremap <leader>t :TagbarToggle<cr>
" }}}

" lightline {{{
" toggle lightline
nnoremap <silent> <leader>L :exec lightline#toggle()<cr>
" }}}

" Syntastic {{{
" stop eating my CPU on save
let g:syntastic_mode_map = {
      \ "mode": "passive",
      \ "active_filetypes": [],
      \ "passive_filetypes": [] }
" opens errors in the location list
nnoremap <leader>e :Errors<cr>
" reset Syntastic (clears errors)
nnoremap <leader>r :SyntasticReset<cr>
" }}}

" Startify {{{
augroup startify_remap
  au!
  " I use <cr> to enter command line mode,
  " so use o to open files instead.
  au User Startified unmap <buffer> <cr>
  au User Startified nmap <buffer> o <Plug>(startify-open-buffers)
augroup END
" custom header
let g:startify_custom_header = [
      \ '                                                   ',
      \ '     ___________________________                   ',
      \ '    /                           \                  ',
      \ '    |     VIM - Vi IMproved     |                  ',
      \ '    |    -------------------    |                  ',
      \ '    |  by Bram Moolenaar et al. |                  ',
      \ '    \_________   _______________/                  ',
      \ '              \ /        ,.                        ',
      \ '               \\      (_|,.                       ',
      \ '                \\    ,'' /, )_______   _          ',
      \ '                   __j o``-''        `.''-)        ',
      \ '                  (")                 \''          ',
      \ '                   `-j                |            ',
      \ '                     `-._(           /             ',
      \ '                 hjw    |_\  |--^.  /              ',
      \ '                       /_]''|_| /_)_/              ',
      \ '                          /_]''  /_]''             ',
      \ '                                                   ',
      \ ]
" }}}

" }}}
" ===========================================================================
