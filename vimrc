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
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" Program
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'AnsiEsc.vim'
" Utility
NeoBundle 'banyan/recognize_charcode.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'The-NERD-tree'
" Syntax
NeoBundle 'nginx.vim'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'leshill/vim-json'
NeoBundle 'yuroyoro/vim-python'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-stylus'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'Indent-Guides'
" Extend
NeoBundle 'slindberg/vim-colors-smyck'
filetype plugin indent on

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif

"
" Module configuration
"
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
augroup END
command! Pt :set paste!
set wildmenu               " コマンド補完を強化
set wildchar=<tab>         " コマンド補完を開始するキー
set wildmode=list:full     " リスト表示，最長マッチ
set history=1000           " コマンド・検索パターンの履歴数
set complete+=k            " 補完に辞書ファイル追加

cnoremap <C-p> <Up>
cnoremap <Up>  <C-p>
cnoremap <C-n> <Down>
cnoremap <Down>  <C-n>

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3

imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

inoremap <expr><Up> neocomplcache#close_popup()."\<Up>"
inoremap <expr><Down> neocomplcache#close_popup()."\<Down>"
inoremap <expr><Left> neocomplcache#close_popup()."\<Left>"
inoremap <expr><Right> neocomplcache#close_popup()."\<Right>"

nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=0
let g:NERDTreeMouseMode=2

let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✓'
let g:gitgutter_sign_removed = '✘'

let g:lightline = {
        \   'colorscheme': 'landscape',
        \   'mode_map': {'c': 'NORMAL'},
        \   'active': {
        \     'left': [
        \       ['mode', 'paste'],
        \       ['fugitive', 'gitgutter', 'filename'],
        \     ],
        \     'right': [
        \       ['lineinfo', 'syntastic'],
        \       ['percent'],
        \       ['charcode', 'fileformat', 'fileencoding', 'filetype'],
        \     ]
        \   },
        \   'component_function': {
        \     'modified': 'MyModified',
        \     'readonly': 'MyReadonly',
        \     'fugitive': 'MyFugitive',
        \     'filename': 'MyFilename',
        \     'fileformat': 'MyFileformat',
        \     'filetype': 'MyFiletype',
        \     'fileencoding': 'MyFileencoding',
        \     'mode': 'MyMode',
        \     'syntastic': 'SyntasticStatuslineFlag',
        \     'gitgutter': 'MyGitGutter',
        \   }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '!' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '! '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

"" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
"function! MyCharCode()
"  if winwidth('.') <= 70
"    return ''
"  endif
"
"  " Get the output of :ascii
"  redir => ascii
"  silent! ascii
"  redir END
"
"  if match(ascii, 'NUL') != -1
"    return 'NUL'
"  endif
"
"  " Zero pad hex values
"  let nrformat = '0x%02x'
"
"  let encoding = (&fenc == '' ? &enc : &fenc)
"
"  if encoding == 'utf-8'
"    " Zero pad with 4 zeroes in unicode files
"    let nrformat = '0x%04x'
"  endif
"
"  " Get the character and the numeric value from the return value of :ascii
"  " This matches the two first pieces of the return value, e.g.
"  " "<F>  70" => char: 'F', nr: '70'
"  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')
"
"  " Format the numeric value
"  let nr = printf(nrformat, nr)
"
"  return "'". char ."' ". nr
"endfunction

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
set listchars=tab:›\ ,eol:\ ,trail:~


"
" Moveto last edited line
"
au BufWritePost * mkview
autocmd BufReadPost * loadview


"
" File handling
"
set fileencodings=utf-8
set fileformats=unix,dos
set encoding=utf-8
set fileformat=unix
filetype plugin on
au BufRead,BufNewFile *.ru    set ft=ruby
au BufRead,BufNewFile *.twig  set ft=jinja.html
au BufRead,BufNewFile *.less  set ft=less
au BufRead,BufNewFile *.json  set ft=json
au BufRead,BufNewFile *.txt   set ft=markdown
au BufRead,BufNewFile *.txt   set foldmethod=marker
au BufRead,BufNewFile *.scala set ft=java.scala
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile /etc/nginx/configs/* set ft=nginx

"
" Coloring
"
syntax enable
set background=dark
colorscheme smyck
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
" Indentation
"
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_color_change_percent = 20
let g:indent_guides_guide_size = 1
hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey

"
" Remove trail
"
autocmd BufWritePre * :%s/\s\+$//ge

"
" Auto Commands
"
autocmd FileType quickrun AnsiEsc
