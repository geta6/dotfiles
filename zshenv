typeset -U PATH CDPATH FPATH MANPATH

# ENV
export EDITOR=`which vim`
[[ -f /usr/local/bin/vim ]] && export EDITOR=/usr/local/bin/vim
export TERM=xterm-256color
export LISTMAX=0
export CLICOLOR=1
export LSCOLORS=exfxbxdxcxhegedabagahcdx
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=32:bd=34:cd=34:su=42:sg=46:tw=42:ow=34;42:or=40;31'
export ZLS_COLORS=$LS_COLORS

# LANG
local JA=ja_JP.UTF-8
local EN=en_US.UTF-8
export LANG=$JA
export LC_CTYPE=$EN
export LC_NUMERIC=$EN
export LC_TIME=$EN
export LC_COLLATE=$JA
export LC_MONETARY=$JA
export LC_MESSAGES=$EN
export LC_PAPER=$EN
export LC_NAME=$JA
export LC_ADDRESS=$JA
export LC_TELEPHONE=$JA
export LC_MEASUREMENT=$JA
export LC_IDENTIFICATION=$JA
export LC_ALL=

# PATH
FPATH=$HOME/.zsh/site-functions:/usr/local/share/zsh-completions:/usr/local/share/zsh/site-functions:$FPATH
PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
[[ -s `which brew` ]] && [[ -s `brew --prefix coreutils` ]] && PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
[[ -s /usr/X11 ]] && PATH=$PATH:/usr/X11/bin
export FPATH PATH

# GIT
export GIT_EDITOR=$EDITOR

# RUBY
[[ -d /usr/local/opt/rbenv ]] && export RBENV_ROOT=/usr/local/opt/rbenv
[[ -s $RBENV_ROOT ]] && export PATH=$RBENV_ROOT/bin:$PATH && eval "$(rbenv init -)"

# BREW
if type brew >/dev/null 2>&1; then
  if [[ -f `brew --prefix`/Library/Contributions/brew_zsh_completion.sh ]]; then
    source `brew --prefix`/Library/Contributions/brew_zsh_completion.sh >/dev/null 2>&1
  fi
  if [[ -f `brew --prefix`/etc/profile.d/z.sh ]]; then
    . `brew --prefix`/etc/profile.d/z.sh
  fi
fi
