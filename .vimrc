" vimrc
" Author: Austin Smith <AssailantLF@gmail.com>
" Source: https://github.com/AssailantLF/vimrc

" Organized with folds, try to use them

" ** STARTUP **                                           {{{1
" ============================================================

" Windows/Linux differences
" I don't really own/use Macs currently
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

" Install Vim-Plug if it isn't installed {{{2
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
Plug 'scrooloose/Syntastic'         " real time error checking
Plug 'scrooloose/NERDCommenter'     " intensely pleasant commenting
Plug 'kien/CtrlP.vim'               " fuzzy file/buffer search
Plug 'jeetsukumaran/vim-filebeagle' " vinegar inspired file manager
Plug 'godlygeek/Tabular'            " text alignment plugin
Plug 'bkad/CamelCaseMotion'         " movement by CamelCase
Plug 'kurkale6ka/vim-pairs'         " more punctuation text objects
Plug 'tommcdo/vim-exchange'         " easy text exchange for vim
Plug 'takac/vim-hardtime'           " stop hjkl-ing so much
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
set t_Co=256          " allow more colors

" fallback default colorscheme
colorscheme desert
" colorscheme of choice
silent! colorscheme blackwolf

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
" change ; to : if there's an error
au VimResized * ;wincmd =

" ** TEXT AND FORMATTING **                               {{{1
" ============================================================

set encoding=utf-8    " consistent character encoding
set cpoptions+=$      " $ as end marker for the change operator
set autoindent        " always set autoindenting on
set smartindent       " trying out smartindent for C
set foldmethod=syntax " default fold method
set nofoldenable      " all folds open initially
set list              " don't show 'listchars' characters

" how to display certain characters/indicators
set listchars=tab:►\ ,eol:¬,trail:·,extends:>,precedes:<

" don't show trailing spaces in insert mode
augroup trailing
  au!
  au InsertEnter * :set listchars-=trail:·
  au InsertLeave * :set listchars+=trail:·
augroup END

" default tab settings
set tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab

" filetype specific formatting
augroup filetype_format
  au!
  " constantly reset formatoptions because Vim's default
  " ftplugins can overwrite them, which is lame
  au BufEnter * :set formatoptions=rq1j

  au FileType vim  :setlocal ts=2 sts=0 sw=2 et fdm=marker
  au FileType sh   :setlocal ts=2 sts=0 sw=2 et
  au FileType html :setlocal ts=2 sts=0 sw=2 et
  au FileType c    :setlocal ts=8 sts=0 sw=8 noet
  au FileType cpp  :setlocal ts=8 sts=0 sw=8 noet
augroup END

" use decimal instead of octal with ctrl-a and ctrl-x
set nrformats=

" fonts
if s:running_windows
  set guifont=DejaVu_Sans_Mono:h11
else
  set guifont=Liberation\ Mono\ 11
end

" highlight 81st column if reached
" (may be slightly inaccurate with linebreak enabled)
" Example line Example line Example line Example line Example line Example li>>>E<<<ple line
function! MarkMargin (on)
  highlight colorcolumn ctermbg=DarkRed
  highlight colorcolumn guibg=DarkRed
  if exists('b:MarkMargin')
    try
      call matchdelete(b:MarkMargin)
    catch /./
    endtry
    unlet b:MarkMargin
  endif
  if a:on
    let b:MarkMargin = matchadd('ColorColumn', '\%81v', 100)
  endif
endfunction

augroup MarkMargin
  autocmd!
  autocmd BufEnter * :call MarkMargin(1)
augroup END

" ** KEYS/MAPS/ALIASES **                                 {{{1
" ============================================================
"
" anything related to plugins is located
" under its respective vim plugins section

" * REMAPS OF DEFAULTS *      {{{2

" swap ; and : for pinky's sake
noremap ; :
noremap : ;

" K for Kill window
noremap K :quit<CR>

" [S]plit line (sister to [J]oin lines)
" cc still substitutes the line like S would
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>

" Y yanks until EOL, more like D and C
" yy still yanks the whole line
nnoremap Y y$

" go substitute because a map for sleeping is silly
nnoremap gs :%s/\<\>/<Left><Left><Left>

" visually select the last paste or change
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" switch to last buffer, like alt+tab
nnoremap <Backspace> :b#<CR>

" left and right arrow keys scroll through buffers
noremap <Left> :bp<CR>
noremap <Right> :bn<CR>

" up and down arrow keys scroll the screen like a browser
noremap <Up> <C-y>
noremap <Down> <C-e>

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
vnoremap p p`]
nnoremap p p`]

" * CONVENIENCE MAPS *       {{{2

" change to current buffer's directory
" (see Aliases section for more on %%)
map <silent> cd ;cd %%<CR>

" visually select all
nnoremap vaa ggVG

" saving habits
nnoremap <silent> <C-s> :update<CR>

" quick insert mode navigation
" only for emergencies /s
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" navigating between windows
noremap <silent> <C-h> <C-w>h<CR>
noremap <silent> <C-j> <C-w>j<CR>
noremap <silent> <C-k> <C-w>k<CR>
noremap <silent> <C-l> <C-w>l<CR>

" resizing windows
noremap <silent> <C-Left>  :vertical resize -10<CR>
noremap <silent> <C-Up>    :resize +10<CR>
noremap <silent> <C-Down>  :resize -10<CR>
noremap <silent> <C-Right> :vertical resize +10<CR>

" go to beginning/end of text
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Go Continuous Scroll-Binding
" This will vertically split the current buffer into two which will stay
" scroll-bound together.  Allows you to see twice as much code at once
" (disables the wrap setting and expands folds to work better)
nnoremap <silent> gcsb :<C-u>let @z=&so<CR>:set so=0 noscb nowrap nofen<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" * LEADER MAPS *             {{{2

" leader the easiest key to reach
let mapleader = "\<Space>"

" edit files from current file's directory without switching directories
" open in [w]indow [s]plit [v]split or [t]ab
" (see Aliases section for more on %%)
map <Leader>ew ;e %%
map <Leader>es ;sp %%
map <Leader>ev ;vsp %%
map <Leader>et ;tabe %%

" open vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>V :tabnew $MYVIMRC<CR>

" quickly manage buffers
nnoremap <Leader>b :ls<CR>:b 
nnoremap <Leader>B :ls!<CR>:b 

" delete buffer
nnoremap <silent> <Leader>X :bd!<CR>

" delete buffer, but not split
nnoremap <silent> <Leader>D :b#<CR>:bd!#<CR>

" copy and paste from system clipboard easier
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p d"+P

" * COMMAND ALIASES *       {{{2

" expands %% to current file's directory in command-line mode
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

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

" Only load these settings if Vim-Plug seems to be installed
if filereadable(expand(g:myvimdir . "/autoload/plug.vim"))

  " Fugitive {{{2
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <Leader>gd :Gdiff<CR>
  nnoremap <Leader>gD :Gdiff HEAD<CR>
  nnoremap <Leader>gc :Gcommit<CR>
  nnoremap <Leader>gl :Git log<CR>
  nnoremap <Leader>gp :Git push<CR>
  nnoremap <Leader>gw :Gwrite<CR>
  nnoremap <Leader>gr :Gremove<CR>

  " CtrlP {{{2
  " include hidden files
  let g:ctrlp_show_hidden = 1
  " specific directory search
  nnoremap <Leader><C-p> :CtrlP 
  " quick access to recent files and buffers
  nnoremap <Leader><C-e> :CtrlPMRUFiles<CR>
  nnoremap <Leader><C-b> :CtrlPBuffer<CR>

  " FileBeagle {{{2
  " no default maps
  let g:filebeagle_suppress_keymaps = 1
  " show hidden files
  let g:filebeagle_show_hidden = 1
  " open current buffer directory
  map <silent> - <Plug>FileBeagleOpenCurrentBufferDir
  " open a specific directory
  nnoremap <Leader>f :FileBeagle 

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

  " Syntastic {{{2
  " reset Syntastic (clears errors)
  nnoremap <Leader>S :SyntasticReset<CR>

  " vim-airline {{{2
  " theme
  let g:airline_theme = 'base16'
  " airline toggle
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

endif
