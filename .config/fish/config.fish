if status is-interactive
    # Use eza instead of ls
    if command -v eza >/dev/null
        alias ls="eza --oneline --group-directories-first --icons"
    end

    # Use eza instead of tree
    if command -v eza >/dev/null
        alias tree="eza --tree --group-directories-first --icons"
    end

    # Disable fish greeting
    set fish_greeting

    # Set alias vim=nvim
    alias vim="nvim"

    set -gx EDITOR (which nvim)
    set -gx VISUAL $EDITOR
    set -gx SUDO_EDITOR $EDITOR

    # Enable vim keybindings (without changing some useful default shorcuts)
    fish_hybrid_key_bindings
    bind yy fish_clipboard_copy
    bind p fish_clipboard_paste
    # The other copy vim commands doesn't work yet

    # Initialize zoxide
    if test -n "$__fish_bin_dir"
        set zoxide_bin "$__fish_bin_dir/zoxide"
    else
        set zoxide_bin zoxide
    end

    # Create alias for zoxide
    alias z='$zoxide_bin'

    # Add zoxide support
    eval "$($zoxide_bin init fish)"

    # Add bat theme
    export BAT_THEME="Dracula"

    # Set up GHCUP environment variables
    if test -d /home/domi/.ghcup/bin
        set -gx PATH /home/domi/.ghcup/bin $PATH
    end

    if test -d $HOME/.cabal/bin
        set -gx PATH $HOME/.cabal/bin $PATH
    end
end
