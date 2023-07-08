source ~/.vim/vim_config
" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin
behave xterm

filetype indent on
let g:moria_style="dark"
set term=xterm
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
colo xoria256       " Colorscheme


" {{{ generell settings
" no menu or toolbar - this must be set separately or nothing is set
set guioptions-=m guioptions-=T guicursor=i:ver12,a:blinkoff0
" set the cursor shape in terminal
if &term =~ "^xterm\\|rxvt"
	let &t_SI = "\<Esc>[6 q"
	let &t_SR = "\<Esc>[4 q"
	let &t_EI = "\<Esc>[2 q"
	" 1 or 0 -> blinking block
	" 2 solid block
	" 3 blinking underscore
	" 4 solid underscore
	" Recent versions of xterm (282 or above) also support
	" 5 -> blinking vertical bar
	" 6 -> solid vertical bar
endif
set linespace=0  " no space between the lines
set nocompatible " that's a vim!
set laststatus=2 " show always status line
set showmode     " show INSERT/REPLACE/...
set cursorline
" my statusline
" set statusline=%<%t[%M%R%H%W%{strftime(\"%d.%m.%y\ %H:%M\",getftime(expand(\"%:p\")))}]%=\ %c%V,%l,%o,%p%%[%LL]
" title of tab pages
set guitablabel=%M%t
" my titlebar
set title titlelen=0 titlestring=%M\ %F

set showmatch matchtime=2   " show matching brackets
" don't wrap, but when wrap then at the end of the window
set nowrap wrapmargin=0
" show line-numbers, but use at least space as possible
set number numberwidth=1
" really minimized windows
set winminwidth=0
set visualbell   " visual bell instead of a beep
set hlsearch     " highlight search results
set incsearch    " incremental search
" remove the search highlighting
noremap <silent> <C-N> :nohlsearch<CR>
syntax on        " Syntax-Highlightning on
set backspace=indent,eol,start " allow backspacing over all in insert mode
set whichwrap+=<,>,[,] " move to the previous/next line with left/right
" what to save when saving session
set sessionoptions=blank,buffers,curdir,options,winsize,winpos,resize
set foldlevelstart=1
set foldmethod=syntax
let javaScript_fold=1
set foldcolumn=2 " folding use only 2 columns
set nojoinspaces " insert only 1 space, when joining lines
" change to the directory of the current file
if has("netbeans_enable")
  set autochdir
endif
set wildmenu     " use a menu for completion
set ignorecase   " Case is completely ignored
set smartcase    " Case only matters if capitel letters are used

" set encoding=iso-8859-15
set encoding=utf8
if has("win32")
	set fileformats=dos,unix,mac
elseif has("unix")
	set fileformats=unix,dos,mac
endif

set mousemodel=popup_setpos
set list listchars=tab:»-,trail:·,precedes:«,extends:»
set guifont=Hasklug\ Nerd\ Font\ Regular\ 10
"set guifont=Hack\ Nerd\ Font\ Regular\ 10
" }}}



set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '"' . $VIMRUNTIME . '\diff"'
      let eq = '""'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

call plug#begin($VIM_FILES.'/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'dsawardekar/ember.vim'
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'dsawardekar/portkey'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'https://github.com/diepm/vim-rest-console'
  Plug 'https://github.com/pangloss/vim-javascript'
	Plug 'johngrib/vim-game-code-break'
	Plug 'qstrahl/vim-matchmaker'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'airblade/vim-gitgutter'
call plug#end()

" {{{ commenting
let g:NERDCommentWholeLinesInVMode=0
let g:NERDAllowAnyVisualDelims=1
let g:NERDRemoveExtraSpaces=0
let g:NERDSpaceDelims=1
let g:NERDMenuMode=0
let g:NERDCompactSexyComs=1

imap <M-c> <C-O><leader>ci<C-O>j
nmap <M-c> :let pos=col(".")<CR><leader>cij:call cursor(0, pos)<CR>
vmap <M-c> <leader>csgv
nmap <C-c> :let pos=col(".")<CR>Y<leader>ccp:call cursor(0, pos)<CR>
imap <C-c> <C-O>:let pos=col(".")<CR><C-O>Y<C-O><leader>cc<C-O>p<C-O>:call cursor(0, pos)<CR>
" }}}

" {{{ vim-airline
let g:airline_theme='bubblegum'
" }}}

" {{{ NERDTree
nnoremap <F8> :NERDTreeTabsToggle<CR>
inoremap <F8> <C-O>:NERDTreeTabsToggle<CR>
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
" }}}

" {{{ some mappings concerning the display of text
" Matchmaker
nnoremap <silent> <C-m> :<C-u>MatchmakerToggle<CR>
let g:matchmaker_enable_startup = 1

highlight Matchmaker guibg=#555555

" Toggle Line-Wrapping (for Display only)
nnoremap <silent> <F9> :set wrap!<CR>
inoremap <silent> <F9> <C-O>:set wrap!<CR>

" Toggle Syntax-highlight
nnoremap <silent> <F11> :call ToggleSyntax()<CR>
inoremap <silent> <F11> <C-O>:call ToggleSyntax()<CR>

function! ToggleSyntax()
  if has("syntax_items")
    syntax off
  else
    syntax on
  endif
endfunction

" Toggle line-numbers
nnoremap <silent> <F12> :set number!<CR>
inoremap <silent> <F12> <C-O>:set number!<CR>
"}}}

" {{{ (un)indenting...
" auto indenting
set autoindent smarttab shiftwidth=2 shiftround
" set expandtab
set tabstop=2    " spaces shown for a tab
" manual indenting
inoremap <M-Right>   <C-O>>><DOWN>
inoremap <M-Left>    <C-O><<<DOWN>
nnoremap <M-Right>   >><DOWN>_
nnoremap <M-Left>    <<<DOWN>_
inoremap <S-M-Right> <C-O>>>
inoremap <S-M-Left>  <C-O><<
nnoremap <S-M-Right> >>_
nnoremap <S-M-Left>  <<_
vnoremap <M-Right>   >gv
vnoremap <M-Left>    <gv
" }}}

" {{{ save with sudo
command W :execute 'w !sudo tee "%" > /dev/null' | :edit!
" }}}

