unction _current_epoch() {
  echo $(($(date +%s) / 60 / 60 / 24))
}

function _update_zsh_update() {
  echo "LAST_EPOCH=$(_current_epoch)" > ~/.zsh-update
}

function _upgrade_zsh() {
  current_path=`pwd`
  printf '\033[0;34m%s\033[0m\n' "Upgrading Oh My Zsh"
  cd $ZSH

  git stash >/dev/null

  if git pull origin master; then
    echo 'dotfiles updated.'
  else
    echo 'There was an error updating.'
  fi

  git stash pop >/dev/null

  cd "$current_path"
  _update_zsh_update
}

if [ -f ~/.zsh-update ]; then
  . ~/.zsh-update

  if [[ -z "$LAST_EPOCH" ]]; then
    _update_zsh_update && return 0;
  fi

  epoch_diff=$(($(_current_epoch) - $LAST_EPOCH))
  if [ $epoch_diff -gt 13 ]; then
    _upgrade_zsh
    _update_zsh_update
  fi
else
  _update_zsh_update
fi