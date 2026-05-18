#!/usr/bin/env bash

# Exit immediately if a command fails.
# Prevents partially installed or broken setups.
set -e

# --------------------------------------------------
# Helper functions
# --------------------------------------------------

log_info() {
  echo "[INFO] $1"
}

log_ok() {
  echo "[OK] $1"
}

log_error() {
  echo "[ERROR] $1"
}

# Backup existing config directories/files
# only if they are real files/directories
# and NOT already symlinks.
backup_if_exists() {
  local path="$1"

  if [ -e "$path" ] && [ ! -L "$path" ]; then
    local backup_path="${path}_backup_$(date +%Y%m%d_%H%M%S)"

    log_info "Backing up: $path"
    mv "$path" "$backup_path"

    log_ok "Backup created: $backup_path"
  fi
}

# Check if a command exists on the system.
require_command() {
  local cmd="$1"

  command -v "$cmd" >/dev/null 2>&1 || {
    log_error "$cmd is required but not installed."
    exit 1
  }
}

# --------------------------------------------------
# Install packages
# --------------------------------------------------

log_info "Updating package lists..."

sudo apt update

log_info "Installing packages from packages/apt.txt..."

# Install all packages listed in apt.txt.
xargs -a packages/apt.txt sudo apt install -y

# --------------------------------------------------
# Verify required commands
# --------------------------------------------------

# These tools are critical for the setup process.
require_command stow
require_command wget
require_command unzip
require_command fc-cache

# --------------------------------------------------
# Install Nerd Font
# --------------------------------------------------

log_info "Installing JetBrainsMono Nerd Font..."

FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="JetBrainsMono"

# Create local font directory if it does not exist.
mkdir -p "$FONT_DIR"

# Install font only if it is not already present.
if [ ! -d "$FONT_DIR/$FONT_NAME" ]; then

  cd "$FONT_DIR"

  log_info "Downloading font archive..."

  wget -q \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

  log_info "Extracting font files..."

  unzip -q JetBrainsMono.zip -d "$FONT_NAME"

  log_info "Cleaning up archive..."

  rm JetBrainsMono.zip

  log_info "Refreshing font cache..."

  fc-cache -fv

  log_ok "JetBrainsMono Nerd Font installed."

else
  log_info "JetBrainsMono Nerd Font already installed."
fi

# --------------------------------------------------
# Deploy dotfiles
# --------------------------------------------------

log_info "Deploying dotfiles..."

DOTFILES_DIR="$HOME/dotfiles"

cd "$DOTFILES_DIR"

# Backup existing user configs before creating symlinks.
backup_if_exists "$HOME/.config/fish"
backup_if_exists "$HOME/.config/kitty"
backup_if_exists "$HOME/.config/ranger"
backup_if_exists "$HOME/.config/nvim"

# Create symlinks using GNU Stow.
stow fish
stow kitty
stow ranger
stow nvim

log_ok "Dotfiles deployed successfully."

# --------------------------------------------------
# Finished
# --------------------------------------------------

log_ok "Installation completed successfully."
