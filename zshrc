autoload -Uz compinit ; compinit
autoload -Uz colors ; colors
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
HISTFILE=${HOME}/.zsh-history
HISTSIZE=10000000
SAVEHIST=100000


bindkey -v
bindkey -a 'q' push-line
bindkey -a 'h' run-help
if [ $LAYOUT = dvorak ]; then
	bindkey "" history-incremental-search-backward
	bindkey "" history-incremental-search-forward
else
	bindkey "" history-incremental-search-backward
	bindkey "" history-incremental-search-forward
fi
bindkey "[3~" delete-char


limit coredumpsize 102400
#unsetopt promptcr
setopt prompt_subst
setopt nobeep
setopt long_list_jobs
setopt list_types
setopt auto_resume
setopt auto_list
setopt hist_ignore_dups
setopt autopushd
setopt pushd_ignore_dups
setopt extended_glob
setopt auto_menu
setopt extended_history
setopt equals
setopt magic_equal_subst
setopt hist_verify
setopt numeric_glob_sort
setopt print_eight_bit
setopt share_history
setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash
setopt correct
setopt noautoremoveslash
setopt complete_aliases
#setopt no_autolist
setopt glob_complete

zstyle ':completion:*' use-cache true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %P Lines: %m
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:approximate:*' max-errors 1
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%}'
zstyle ':completion:*:default' menu select auto
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
zstyle ':completion:::::' completer _complete _approximate
zmodload zsh/complist


case ${UID} in
	0)
		zstyle ':completion:*' command-path $HOME/bin /usr/local/sbin /usr/local/bin /usr/X11/bin /usr/sbin /usr/bin /sbin /bin
		PROMPT="%{${fg[magenta]}%}%n@%m%{${reset_color}%} %{${fg[blue]}%}#%{${reset_color}%} "
		;;
	*)
		zstyle ':completion:*' command-path $HOME/bin /usr/local/bin /usr/X11/bin /usr/bin /bin
		zstyle ':completion:*:sudo:*' command-path $HOME/bin /usr/local/sbin /usr/local/bin /usr/X11/bin /usr/sbin /usr/bin /sbin /bin
		case ${OSTYPE} in
			darwin* )
				PROMPT="%{${fg[cyan]}%}%n@%m%{${reset_color}%} %{${fg[blue]}%}$%{${reset_color}%} "
				;;
			linux* )
				PROMPT="%{${fg[yellow]}%}%n@%m%{${reset_color}%} %{${fg[blue]}%}$%{${reset_color}%} "
				;;
		esac
		;;
esac
PROMPT2="%B%{${fg[magenta]}%}%_#%{${reset_color}%}%b "
SPROMPT="%B%{${fg[magenta]}%}%r is correct? [n,y,a,e] :%{${reset_color}%}%b "


case "${TERM}" in
	kterm*|xterm)
		precmd() {
			echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
		}
		;;
esac


function search() {
	DIR=$1
	KEY=$2
	[[ ! -d $1 && ! -f $1 && $1 != '.' ]] && KEY=$DIR && DIR='.'
	grep --color -n -r -i "$KEY" "$DIR"
}
function count() {
	echo $(( `ls -l | wc -l`-1 )) `du -sh`
}
function psx() {
	ps aux | grep $1 | grep -v grep
}
function rcfresh() {
	local PWD=`pwd`
	[[ -s $HOME/Library/Rcfiles ]] && local RCD=$HOME/Library/Rcfiles
	[[ -s $HOME/lib/rc ]] && local RCD=$HOME/lib/rc
	case $1 in
		'pull' )
			cd ${RCD} ; git pull & ; cd ${PWD}
			;;
		'push' )
			cd ${RCD} ; git commit -a -m 'auto commit' ; git push & ; cd ${PWD}
			;;
		*)
			echo pull or push
	esac
}
function google() {
	if [ -x "`which w3m 2>/dev/null`" ]; then
		local str opt
		if [ $# != 0 ]; then
			for i in $*; do
				str="$str+$i"
			done
			str=`echo $str | sed 's/^\+//'`
			opt="search?num=50&hl=ja&lr=lang_ja&q=${str}"
		fi
		w3m http://www.google.co.jp/$opt
	else
		echo cannot find w3m
	fi
}
function growl() {
	if [ -x "`which growlnotify 2>/dev/null`" ]; then
		local str
		if [ $# != 0 ]; then
			for i in $*; do
				str="$str $i"
			done
		fi
		growlnotify -n "$str" -m "${str}, done."
	fi
}


case "${OSTYPE}" in
	darwin* )
		alias ls="ls -vF"
		;;
	linux* )
		alias ls="ls -vF --color"
		alias dir="dir --color"
		;;
esac
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias c="cd"
alias v="vi"
alias l="ls"
alias q="exit"
alias la="ls -A"
alias ll="ls -l"
alias ld="ls -lA"
alias lla="ld"
alias li="ls -i"
alias ss="sudo su"
alias co="ssh geta6.net"
alias ce="crontab -e"
alias cv="convmv -f utf-8 --nfd -t utf-8 --nfc -r ."
if [ ! ${WINDOW} ]; then
	alias sc="screen -D -RR"
else
	alias sc="screen -d"
fi


preexec () {
	if [ ${WINDOW} ]; then
		echo -ne "\ek${1%% *}\e\\"
	fi
}

__git_files() { _files }
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true
autoload -Uz is-at-least
if is-at-least 4.3.10; then
	zstyle ':vcs_info:git:*' check-for-changes true
	zstyle ':vcs_info:git:*' stagedstr "^"
	zstyle ':vcs_info:git:*' unstagedstr "*"
	zstyle ':vcs_info:git:*' formats '[%s](%b) %c%u'
	zstyle ':vcs_info:git:*' actionformats '[%s](%b|%a) %c%u'
fi
function _update_vcs_info_msg() {
	psvar=()
	LANG=en_US.UTF-8 vcs_info
	[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|)"
RPROMPT="$RPROMPT %{${fg[blue]}%}[%/]%{${reset_color}%}"
