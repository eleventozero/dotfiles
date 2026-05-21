#!/usr/bin/env bash

# Exit immediately if any command fails.
# Prevents half-finished installations and inconsistent states.
set -e

# Public GitHub repository URL.
# HTTPS is recommended for bootstrap scripts because
# it works even on fresh systems without SSH keys.
REPO="https://github.com/eleventozero/dotfiles.git"

# Local target directory where the repo will be cloned.
TARGET="$HOME/dotfiles"

log_info() {
  echo "[INFO] $1"
}

log_ok() {
  echo "[OK] $1"
}

log_error() {
  echo "[ERROR] $1"
}

require_command() {
  local cmd="$1"

  command -v "$cmd" >/dev/null 2>&1 || {
    log_error "$cmd is required but not installed."
    log_error "Install it first, for example: sudo apt install -y $cmd"
    exit 1
  }
}

log_info "Bootstrapping dotfiles..."

# Bootstrap needs git before the repository can be cloned or updated.
require_command git

# Check if the dotfiles directory already exists.
if [ ! -d "$TARGET" ]; then

  log_info "Cloning dotfiles repository..."

  # Clone repository into target directory.
  git clone "$REPO" "$TARGET"

else
  log_info "Dotfiles already exist."
  log_info "Pulling latest changes..."

  # Enter existing repository.
  cd "$TARGET"

  # Update repository.
  # --rebase keeps history cleaner by avoiding unnecessary merge commits.
  git pull --rebase
fi

# Move into repository directory.
cd "$TARGET"

# Ensure install script is executable.
chmod +x install.sh

log_info "Running install.sh..."

# Start main installation process.
./install.sh

log_ok "Bootstrap completed successfully."
