typeset -U PATH CDPATH FPATH MANPATH

EDITOR=/usr/bin/vi
[[ -f /bin/vi ]] && EDITOR=/bin/vi
export EDITOR
export TERM=xterm-256color
export LISTMAX=0
export CLICOLOR=1
export LSCOLORS=exfxbxdxcxhegedabagahcdx
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=32:bd=34:cd=34:su=42:sg=46:tw=42:ow=34;42:or=40;31'
export ZLS_COLORS=$LS_COLORS

FPATH=$HOME/.zsh/site-functions:/usr/local/share/zsh-completions:/usr/local/share/zsh/site-functions:$FPATH
PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
[[ -s `which brew` ]] && [[ -s `brew --prefix coreutils` ]] && PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
[[ -s /usr/X11 ]] && PATH=$PATH:/usr/X11/bin
export FPATH PATH

[[ -d /usr/local/rbenv ]] && export RBENV_ROOT=/usr/local/rbenv
[[ -d /usr/local/opt/rbenv ]] && export RBENV_ROOT=/usr/local/opt/rbenv
[[ -s $RBENV_ROOT ]] && export PATH=$RBENV_ROOT/bin:$PATH && eval "$(rbenv init -)"

if type brew >/dev/null 2>&1; then
  BREW_PREFIX=$(brew --prefix)
  if [ -e $BREW_PREFIX/Library/Contributions/brew_zsh_completion.sh ]; then
    source $BREW_PREFIX/Library/Contributions/brew_zsh_completion.sh >/dev/null 2>&1
  fi
fi

export GIT_EDITOR=/usr/bin/vim

