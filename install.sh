#!/usr/bin/env bash

set -e

echo "Installing packages..."

sudo apt update
xargs -a packages/apt.txt sudo apt install -y

echo "Installing fonts..."

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

if [ ! -d "$FONT_DIR/JetBrainsMono" ]; then
  cd "$FONT_DIR"
  wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -q JetBrainsMono.zip -d JetBrainsMono
  rm JetBrainsMono.zip
  fc-cache -fv
fi

echo "Installing dotfiles..."

cd "$HOME/dotfiles"

stow fish
stow kitty
stow ranger
stow nvim

echo "Done."
