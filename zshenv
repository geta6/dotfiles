[[ -f /usr/share/zsh/zshenv ]] && source /usr/share/zsh/zshenv
typeset -U PATH CDPATH FPATH MANPATH

LANGUAGE=C
LC_ALL=C
LC_CTYPE=ja_JP.UTF-8
LC_MESSAGES=en_US.UTF-8
LANG=en_US.UTF-8
export LANGUAGE LC_ALL LC_CTYPE LC_MESSAGES LANG

EDITOR=/usr/bin/vi
[[ -s /bin/vi ]] && EDITOR=/bin/vi
export EDITOR

TERM=xterm-256color
export TERM

FPATH=$HOME/.zsh/functions/Completion:/usr/local/share/zsh/site-functions:$FPATH
fpath=(/usr/local/share/zsh-completions $fpath)
PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
[[ -s `which brew` ]] && [[ -s `brew --prefix coreutils` ]] && PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
[[ -s /usr/X11 ]] && PATH=$PATH:/usr/X11/bin
[[ -s /usr/local/share/python ]] && PATH=/usr/local/share/python:$PATH
[[ -s /usr/local/share/npm/bin ]] && PATH=$PATH:/usr/local/share/npm/bin
[[ -s /usr/local/heroku/bin ]] && PATH=$PATH:/usr/local/heroku/bin
[[ -s /usr/local/SPTK ]] && PATH=$PATH:/usr/local/SPTK/bin
export FPATH PATH

[[ -s "${HOME}/.pythonbrew/etc/bashrc" ]] && source $HOME/.pythonbrew/etc/bashrc
[[ -s `which virtualenvwrapper.sh` ]] && source `which virtualenvwrapper.sh`
[[ -s /usr/local/share/python/virtualenvwrapper.sh ]] && source /usr/local/share/python/virtualenvwrapper.sh

LISTMAX=0
CLICOLOR=1
LSCOLORS=exfxbxdxcxhegedabagahcdx
LS_COLORS='di=34:ln=35:so=32:pi=33:ex=32:bd=34:cd=34:su=42:sg=46:tw=42:ow=34;42:or=40;31'
export LISTMAX CLICOLOR LSCOLORS LS_COLORS
export ZLS_COLORS=$LS_COLORS

if [[ -s $HOME/.nvm ]]; then
  . $HOME/.nvm/nvm.sh
else
  [[ -s /usr/local/nvm ]] && . /usr/local/nvm/nvm.sh
  [[ -s /usr/local/share/nvm ]] && . /usr/local/share/nvm/nvm.sh
fi

export PERL_CPANM_OPT='--local-lib=/usr/local/share/perl'
export PERL5LIB='/usr/local/share/perl/lib/perl5'

[[ -f $HOME/perl5/perlbrew/etc/bashrc ]] && source $HOME/perl5/perlbrew/etc/bashrc

[[ -s /usr/local/lib/node_modules ]] && NODE_PATH=/usr/local/lib/node_modules && export NODE_PATH

if [[ -s $HOME/.rvm ]]; then
  . $HOME/.rvm/scripts/rvm
  PATH=$PATH:$HOME/.rvm/bin
  export PATH
else
  [[ -s /usr/local/rvm ]] && . /usr/local/rvm/scripts/rvm
  [[ -s /usr/local/share/rvm ]] && . /usr/local/share/rvm/scripts/rvm
fi

if type brew >/dev/null 2>&1; then
  BREW_PREFIX=$(brew --prefix)
  if [ -e $BREW_PREFIX/Library/Contributions/brew_zsh_completion.sh ]; then
    source $BREW_PREFIX/Library/Contributions/brew_zsh_completion.sh >/dev/null 2>&1
  fi
fi

export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
