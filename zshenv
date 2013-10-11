[[ -f /usr/share/zsh/zshenv ]] && source /usr/share/zsh/zshenv
typeset -U PATH CDPATH FPATH MANPATH

EDITOR=/usr/bin/vi
[[ -s /bin/vi ]] && EDITOR=/bin/vi
export EDITOR

export TERM=xterm-256color

FPATH=$HOME/.zsh/functions/Completion:/usr/local/share/zsh/site-functions:$FPATH
PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
[[ -s `which brew` ]] && [[ -s `brew --prefix coreutils` ]] && PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
[[ -s /usr/X11 ]] && PATH=$PATH:/usr/X11/bin
export FPATH PATH

export RBENV_ROOT=/usr/local/rbenv
export PATH=/usr/local/rbenv/bin:$PATH
eval "$(rbenv init -)"

LISTMAX=0
CLICOLOR=1
LSCOLORS=exfxbxdxcxhegedabagahcdx
LS_COLORS='di=34:ln=35:so=32:pi=33:ex=32:bd=34:cd=34:su=42:sg=46:tw=42:ow=34;42:or=40;31'
export LISTMAX CLICOLOR LSCOLORS LS_COLORS
export ZLS_COLORS=$LS_COLORS

if type brew >/dev/null 2>&1; then
  BREW_PREFIX=$(brew --prefix)
  if [ -e $BREW_PREFIX/Library/Contributions/brew_zsh_completion.sh ]; then
    source $BREW_PREFIX/Library/Contributions/brew_zsh_completion.sh >/dev/null 2>&1
  fi
fi

export LANG="ja_JP.UTF-8"
export LC_ALL="ja_JP.UTF-8"
export GIT_EDITOR=/usr/bin/vim
