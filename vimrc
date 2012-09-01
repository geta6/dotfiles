"Default Setting
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

"Vundle"
set nocompatible
filetype off
set rtp+=~/.vim/vundle/
call vundle#rc()
"http://vim-scripts.org/vim/scripts.html
Bundle 'JSON.vim'
Bundle 'css3'
Bundle 'jQuery'
Bundle 'neco-look'
Bundle 'neocomplcache'
Bundle 'vim-coffee-script'
Bundle 'jade.vim'
Bundle 'dmd'
Bundle 'scala.vim'
Bundle 'thinca/vim-quickrun'
Bundle 'sickill/vim-monokai'
Bundle 'groenewege/vim-less'
Bundle 'rdunklau/Jinja.vim'
filetype plugin indent on

"Global Configuration"
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

"Vimproc"
"if has('unix') && match(system('uname'),'Darwin') != -1
"  let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/procmac.so'
"elseif has('unix')
"  let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/procunix.so'
"endif

"Auto Complete"
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_manual_completion_start_length = 3
let g:neocomplcache_min_keyword_length = 4
let g:neocomplcache_min_syntax_length = 4
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_enable_cursor_hold_i = 0
let g:neocomplcache_enable_camel_case_completion = 0
let g:neocomplcache_enable_underbar_completion = 0
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'
let g:neocomplcache_temporary_dir = '/tmp/.neocon'
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<BS>"
inoremap <expr><Up> neocomplcache#smart_close_popup()."\<Up>"
inoremap <expr><Down> neocomplcache#smart_close_popup()."\<Down>"
inoremap <expr><Return> pumvisible() ? neocomplcache#close_popup() : "\<Return>"
imap <silent> <C-k> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-k> <Plug>(neocomplcache_snippets_expand)
nnoremap j gj
onoremap j gj
xnoremap j gj
nnoremap k gk
onoremap k gk
xnoremap k gk

"Special Keys"
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

"Status Highlight"
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

"Move Cursor"
au BufWritePost * mkview
autocmd BufReadPost * loadview

"Indent"
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 3
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=grey

"File handle"
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

"Color"
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

"Auto Fixer"
autocmd BufWritePre * :%s/\s\+$//ge

"Shortcut"
nmap <silent> <leader>t <ESC><UP>0o<C-R>=strftime("%Y/%m/%d (%a) %H:%M")<CR>
nmap <silent> <leader>y i<link rel='stylesheet' href='//yui.yahooapis.com/3.5.1/build/cssreset/cssreset-min.css'>
nmap <silent> <leader>j i<script src='//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'></script>
set helpfile=$VIMRUNTIME/doc/help.txt

