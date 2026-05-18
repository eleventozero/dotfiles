function fish_prompt

    # -------------------------------------------------
    # SSH Session Indicator
    # -------------------------------------------------

    # Display username and hostname when connected
    # to a remote machine via SSH.
    if test -n "$SSH_TTY"

        echo -n \
            (set_color brred)"$USER" \
            (set_color white)'@' \
            (set_color yellow)(prompt_hostname)' '

    end

    # -------------------------------------------------
    # Current Working Directory
    # -------------------------------------------------

    # Display the current path using Fish's compact
    # path formatter.
    echo -n \
        (set_color blue)(prompt_pwd)' '

    # Enable bold text rendering.
    set_color -o

    # -------------------------------------------------
    # Root User Warning
    # -------------------------------------------------

    # Show a red # when running as root.
    # Helps prevent accidental system modifications.
    if fish_is_root_user

        echo -n \
            (set_color red)'# '

    end

    # -------------------------------------------------
    # Prompt Symbol
    # -------------------------------------------------

    # Minimal colorful prompt arrows.
    # Colors are intentionally subtle so the Kitty
    # terminal theme remains the primary visual style.
    echo -n \
        (set_color red)'❯' \
        (set_color yellow)'❯' \
        (set_color green)'❯ '

    # Reset terminal colors.
    set_color normal

end
