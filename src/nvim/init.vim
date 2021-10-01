if 0 | endif

nnoremap ; :

scriptencoding utf-8
set fileencodings=utf-8
set fileformats=unix,dos
set encoding=utf-8
set fileformat=unix

set nobackup
set noswapfile
set autoread
set hidden
set showcmd

set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
set title

set list
set listchars=tab:>\ ,
set expandtab
set tabstop=2
set shiftwidth=2

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set noautoindent
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

set ambiwidth=double
set matchtime=1
set ruler
set number
set autowrite
set scrolloff=5
set history=1000
set nowrap
set wildmenu
set wildchar=<tab>
set complete+=k
set lazyredraw
set backspace=indent,eol,start

if has('persistent_undo')
  set undofile
  set undodir=$HOME/.vim/undo
endif


" Path


" https://yu8mada.com/2018/08/03/how-to-install-neovim-on-macos-using-homebrew-and-set-it-up-to-make-it-able-to-be-used/
" :checkhealth to check status
let g:ruby_host_prog = expand('~/.anyenv/envs/rbenv/shims/neovim-ruby-host')
"let g:node_host_prog
"let g:python_host_prog
let g:python3_host_prog = expand('~/.anyenv/envs/pyenv/shims/python')


" dein


if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " https://rcmdnk.com/blog/2017/11/16/computer-vim/
  if ((has('nvim') || has('timers')) && has('python3')) && system('pip3 show neovim') !=# ''
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
    call dein#add('Shougo/deoplete.nvim')
  elseif has('lua')
    call dein#add('Shougo/neocomplete.vim')
  endif

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  " https://rcmdnk.com/blog/2017/09/25/computer-vim/
  if has('nvim') || (has('job') && has('channel') && has('timers'))
    call dein#add('w0rp/ale')
  else
    call dein#add('vim-syntastic/syntastic')
  endif

  call dein#add('airblade/vim-gitgutter')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('TomLingham/dracula.vim')
  call dein#add('thinca/vim-quickrun')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif


" Plugin settings

filetype plugin indent on
syntax enable

if dein#tap('dracula.vim')
  colorscheme dracula
endif

if dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
elseif dein#tap('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
endif

if dein#tap('ale')
  let g:ale_lint_on_enter = 0
  let g:ale_sign_column_always = 1
  let g:ale_sh_shellcheck_options = '-e SC1090,SC2059,SC2155,SC2164'

  if dein#tap('lightline.vim')
    let g:lightline = {
          \'active': {
          \  'left': [
          \    ['mode', 'paste'],
          \    ['readonly', 'filename', 'modified', 'ale'],
          \  ]
          \},
          \'component_function': {
          \  'ale': 'ALEGetStatusLine'
          \}
          \ }
  endif
endif

if dein#tap('vim-gitgutter')
  set updatetime=250
  hi GitGutterAdd ctermfg=darkgreen
  hi GitGutterChange ctermfg=yellow
  hi GitGutterDelete ctermfg=darkred
endif

if !has('gui_running')
  set t_Co=256
endif

