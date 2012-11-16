TRY="\033[36m"
OK="\033[32m"
NG="\033[35m"
END="\033[39m"

if [ -d ~/.dotfiles ]; then
  echo 'You already have "~/.dotfiles".'
  echo "${NG}Installation interrupt.${END}"
  exit
fi

echo "${TRY}Cloning dotfiles...${END}"
hash git >/dev/null && /usr/bin/env git clone https://github.com/geta6/dotfiles ~/.dotfiles || {
  echo 'git not installed.'
  echo "${NG}Installation interrupt.${END}"
  exit
}

echo "${TRY}Looking for an existing zshrc${END}"
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
  echo 'zshrc found'
  echo "${OK}~/.zshrc backing up to ~/.zshrc.pre-dotfiles${END}"
  mv ~/.zshrc ~/.zshrc-pre-dotfiles;
fi

echo "${TRY}Using dotfiles zshrc${END}"
cp ~/.dotfiles/zsh/zshrc.zsh ~/.zshrc

echo "${TRY}Time to change your default shell to zsh${END}"
[[ $SHELL != `which zsh` ]] && chsh -s `which zsh` && echo "${OK}Successfully changed.${END}"

echo $TRY
echo '       __      __  _____ __         '
echo '  ____/ /___  / /_/ __(_) /__  _____'
echo ' / __  / __ \/ __/ /_/ / / _ \/ ___/'
echo '/ /_/ / /_/ / /_/ __/ / /  __(__  ) '
echo '\__,_/\____/\__/_/ /_/_/\___/____/  '
echo $END

echo "${OK}Installed.${END}"
echo ''
echo 'Documents   : https://github.com/geta6/dotfiles'
echo 'Destination : ~/.dotfiles'
echo ''

/usr/bin/env zsh
source ~/.zshrc