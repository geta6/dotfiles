LANG=C
LC_CTYPE=ja_JP.UTF-8
LC_MESSAGES=en_US.UTF-8
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$HOME/bin
[[ -s /usr/X11 ]] && PATH=$PATH:/usr/X11/bin
FPATH=$HOME/.zsh/functions:$FPATH
EDITOR=/usr/bin/vi
[[ -s /bin/vi ]] && EDITOR=/bin/vi
LISTMAX=0
CLICOLOR=1
LSCOLORS=gxfxcxdxbxegedabagacad
LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
PYTHONBREW_ROOT=/usr/local/share/pythonbrew
export LANG LC_CTYPE LC_MESSAGES PATH FPATH EDITOR LISTMAX CLICOLOR LSCOLORS LS_COLORS PYTHONBREW_ROOT
[[ -s $HOME/.nvm ]] && . $HOME/.nvm/nvm.sh
[[ -s $HOME/.rvm/scripts/rvm ]] && . $HOME/.rvm/scripts/rvm
[[ -e /usr/local/Cellar/coreutils/8.12/aliases ]] && source /usr/local/Cellar/coreutils/8.12/aliases
[[ -s /usr/local/share/pythonbrew ]] && . /usr/local/share/pythonbrew/etc/bashrc
