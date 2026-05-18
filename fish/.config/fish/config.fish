# =========================================================
# Fish Shell Configuration
# =========================================================

# =========================================================
# ENVIRONMENT VARIABLES
# =========================================================

# Default terminal editor.
set -gx EDITOR nvim

# Preferred visual editor.
set -gx VISUAL nvim

# Default pager for long text output.
set -gx PAGER less

# Only run this configuration in interactive shells.
# Prevents unnecessary execution in scripts or subprocesses.
if status is-interactive

    # =====================================================
    # BASIC SETTINGS
    # =====================================================

    # Disable the default Fish greeting message.
    set -g fish_greeting ""

    # Central dotfiles path.
    # Makes the configuration easier to maintain.
    set -gx DOTFILES "$HOME/dotfiles"

    # =====================================================
    # MODERN CLI TOOLS
    # =====================================================

    # Use eza instead of ls.
    alias ls="eza"

    # Detailed file listing.
    alias ll="eza -lh"

    # Show hidden files.
    alias la="eza -a"

    # Tree view.
    alias tree="eza --tree"

    # Use bat instead of cat.
    alias cat="bat"

    # =====================================================
    # NAVIGATION
    # =====================================================

    alias ..="cd .."
    alias ...="cd ../.."

    # =====================================================
    # GIT SHORTCUTS
    # =====================================================

    alias ga="git add"
    alias gc="git commit"
    alias gp="git push"

    # Remove Ghostscript alias conflict.
    functions -e gs 2>/dev/null

    # Replace with git status.
    alias gs="git status"

    # =====================================================
    # ZOXIDE
    # =====================================================

    # Smart directory jumping.
    zoxide init fish | source

end
