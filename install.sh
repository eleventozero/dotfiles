#!/usr/bin/env bash
set -e

echo "Installing dotfiles..."

# Install stow if not installed
if ! command -v stow &>/dev/null; then
  echo "Installing stow..."
  sudo apt update
  sudo apt install -y stow
fi

stow fish
stow kitty
stow ranger
stow nvim

echo "Done."
