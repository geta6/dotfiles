"
" Default setting
"
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif


"
" Vundle
"
set nocompatible
filetype off
set rtp+=~/.vim/vundle/
call vundle#rc()
Bundle 'JSON.vim'
Bundle 'css3'
Bundle 'vim-stylus'
Bundle 'vim-coffee-script'
Bundle 'jade.vim'
Bundle 'scala.vim'
Bundle 'thinca/vim-quickrun'
Bundle 'sickill/vim-monokai'
Bundle 'groenewege/vim-less'
Bundle 'rdunklau/Jinja.vim'
filetype plugin indent on

"
" Global configuration
"
set laststatus=2
set showcmd
set showmatch
set matchtime=1
set ignorecase
set smartcase
set wildmenu
set wildchar=<TAB>
set wildmode=full:list
set ruler
set number
set notitle
set autowrite
set hidden
set scrolloff=5
set history=50
set autoread
set incsearch
set hlsearch
set nowrap
set t_Co=256
nmap <ESC><ESC> ;nohlsearch<CR><ESC>
set cursorline
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END


"
" Key remap
"
nnoremap ; :
set virtualedit=block
set backspace=indent,eol,start
set t_kD=[3~
set list
set listchars=tab:⧽\ ,trail:~,extends:»,precedes:«
if has('syntax')
  augroup InsertHook
  autocmd!
  autocmd InsertEnter * call s:StatusLine('Enter')
  autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif


"
" Status highlight
"
let g:hi_insert = 'highlight StatusLine ctermfg=white ctermbg=magenta cterm=none'
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction
function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction


"
" Moveto last edited line
"
au BufWritePost * mkview
autocmd BufReadPost * loadview


"
" Indentation
"
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 3
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=grey


"
" File handling
"
set fileencodings=utf-8,sjis,euc-jp
set fileformats=unix,dos
set encoding=utf-8
set fileformat=unix
filetype plugin on
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile /etc/nginx/conf.d/* set ft=nginx
au BufRead,BufNewFile *.twig  set ft=jinja.html
au BufRead,BufNewFile *.less  set ft=less
au BufRead,BufNewFile *.json  set ft=json
au BufRead,BufNewFile *.txt   set ft=markdown
au BufRead,BufNewFile *.txt   set foldmethod=marker
au BufRead,BufNewFile *.scala set ft=java.scala

"
" Coloring
"
syntax enable
let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1
set background=dark
colorscheme Monokai
function! ActivateInvisibleIndicator()
  hi SpecialKey cterm=NONE ctermfg=darkgray guifg=darkgray
  hi ZenkakuSpace cterm=underline ctermfg=red gui=underline guifg=#FF0000
  match ZenkakuSpace /　/
endfunction
augroup InvisibleIndicator
  autocmd!
  autocmd BufEnter * call ActivateInvisibleIndicator()
augroup END


"
" Remove trail
"
autocmd BufWritePre * :%s/\s\+$//ge
