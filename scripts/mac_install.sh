#!/usr/bin/env bash
set -e

pause() {
  read -p "Press any key to continue..." -r -n 1 -s
  echo
}

if [ "$(uname)" != "Darwin" ]; then
  echo "Not Mac - exiting."
  exit 0
fi

if ! [ -x "$(command -v brew)" ]; then
  echo "== Installing homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "== Installing homebrew packages"
brew bundle

printf "Enter email to use for SSH and GPG: "
read email

if ! [ -f "$HOME/.ssh/id_rsa" ]; then
  echo "== Generating an SSH key"
  ssh-keygen -t rsa -b 4096 -C "$email"
  eval "$(ssh-agent -s)"
  ssh-add -K "$HOME/.ssh/id_rsa"

  pbcopy < "$HOME/.ssh/id_rsa.pub"
  echo "Key copied to the clipboard. Add this key to GitHub: https://github.com/settings/keys"

  pause
fi

if ! (gpg --list-keys | grep -q pubring); then
  echo "== Setting up GPG"
  gpg --full-generate-key
  gpg --armor --export "$email" | pbcopy
  echo "Key copied to the clipboard. Add this key to Github: https://github.com/settings/keys"

  pause

  id=$(gpg --list-keys | sed "4q;d" | awk '{$1=$1}1')
  git config --file "$HOME/.gitconfig.local" user.signingKey "$id"
  git config --file "$HOME/.gitconfig.local" commit.gpgsign true
fi
