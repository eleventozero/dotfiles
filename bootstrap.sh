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

echo "[INFO] Bootstrapping dotfiles..."

# Check if the dotfiles directory already exists.
if [ ! -d "$TARGET" ]; then

  echo "[INFO] Cloning dotfiles repository..."

  # Clone repository into target directory.
  git clone "$REPO" "$TARGET"

else
  echo "[INFO] Dotfiles already exist."
  echo "[INFO] Pulling latest changes..."

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

echo "[INFO] Running install.sh..."

# Start main installation process.
./install.sh

echo "[OK] Bootstrap completed successfully."
