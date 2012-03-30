LANG=C
LC_CTYPE=ja_JP.UTF-8
LC_MESSAGES=en_US.UTF-8
export LANG LC_CTYPE LC_MESSAGES

EDITOR=/usr/bin/vi
[[ -s /bin/vi ]] && EDITOR=/bin/vi
export EDITOR

FPATH=$HOME/.zsh/functions:$FPATH
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$HOME/bin
[[ -s `which brew` ]] && [[ -s `brew --prefix coreutils` ]] && PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
[[ -s /usr/X11 ]] && PATH=$PATH:/usr/X11/bin
export FPATH PATH

LISTMAX=0
CLICOLOR=1
LSCOLORS=exfxbxdxcxhegedabagahcdx
LS_COLORS='di=34:ln=35:so=32:pi=33:ex=32:bd=34:cd=34:su=42:sg=46:tw=42:ow=34;42:or=40;31'
export LISTMAX CLICOLOR LSCOLORS LS_COLORS
export ZLS_COLORS=$LS_COLORS

[[ -s /usr/local/share/pythonbrew ]] && export PYTHONBREW_ROOT=/usr/local/share/pythonbrew
[[ -s $HOME/.nvm ]] && . $HOME/.nvm/nvm.sh
[[ -s $HOME/.rvm/scripts/rvm ]] && . $HOME/.rvm/scripts/rvm
[[ -e /usr/local/Cellar/coreutils/8.12/aliases ]] && source /usr/local/Cellar/coreutils/8.12/aliases
[[ -s /usr/local/share/pythonbrew ]] && . /usr/local/share/pythonbrew/etc/bashrc

