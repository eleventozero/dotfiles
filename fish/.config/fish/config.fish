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

    # ==========================================
    # ZOXIDE (smart cd)
    # ==========================================

    zoxide init fish | source

    function kitty-monalisa
        ln -sf ~/dotfiles/kitty/.config/kitty/themes/MonaLisa.conf ~/dotfiles/kitty/.config/kitty/current-theme.conf
        echo "Switched to MonaLisa"
    end

    function kitty-novel
        ln -sf ~/dotfiles/kitty/.config/kitty/themes/Novel.conf ~/dotfiles/kitty/.config/kitty/current-theme.conf
        echo "Switched to Novel"
    end

end
