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

backup_if_exists() {
  local path="$1"

  if [ -e "$path" ] && [ ! -L "$path" ]; then
    mv "$path" "${path}_backup_$(date +%Y%m%d_%H%M%S)"
  fi
}

backup_if_exists "$HOME/.config/fish"
backup_if_exists "$HOME/.config/kitty"
backup_if_exists "$HOME/.config/ranger"
backup_if_exists "$HOME/.config/nvim"

stow fish
stow kitty
stow ranger
stow nvim

echo "Done."
