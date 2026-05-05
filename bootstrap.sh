#!/usr/bin/env bash

set -e

REPO="git@github.com:eleventozero/dotfiles.git"
TARGET="$HOME/dotfiles"

echo "Bootstrapping dotfiles..."

if [ ! -d "$TARGET" ]; then
  git clone "$REPO" "$TARGET"
fi

cd "$TARGET"

chmod +x install.sh
./install.sh

echo "Bootstrap done."
