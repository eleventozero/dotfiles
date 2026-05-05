#!/usr/bin/env bash

set -e

REPO="https://git@github.com/eleventozero/dotfiles.git"
TARGET="$HOME/dotfiles"

echo "Bootstrapping dotfiles..."

if [ ! -d "$TARGET" ]; then
  git clone "$REPO" "$TARGET"
else
  echo "Dotfiles already exist, pulling latest changes..."
  cd "$TARGET"
  git pull
fi

cd "$TARGET"

chmod +x install.sh
./install.sh

echo "Bootstrap done."
