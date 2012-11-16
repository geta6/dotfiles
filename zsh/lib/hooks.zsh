echo hooks

if [ "$DISABLE_AUTO_UPDATE" != "true" ]; then
  /usr/bin/env ZSH=$ZSH zsh $ZSH/lib/update.sh
fi
