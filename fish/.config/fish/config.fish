if status is-interactive
    # BASIC SETTINGS
    set -g fish_greeting ""

    # ==========================================
    # ALIASES
    # ==========================================

    # -------- Navigation --------
    alias ..="cd .."
    alias ...="cd ../.."

    # -------- Listing --------
    alias ll="ls -lh"
    alias la="ls -a"

    # -------- Git --------
    alias ga="git add"
    alias gc="git commit"
    alias gp="git push"

    # Override ghostscript (gs)
    functions -e gs 2>/dev/null
    alias gs="git status"
end
