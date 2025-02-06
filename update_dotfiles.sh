#!/bin/bash

TARGET_DIR=$(pwd)

copy() {
    local src
    local dest_dir="${1#\.config/}"
    local dest="$TARGET_DIR/$dest_dir"

    if [ "$load" = true ]; then
        # When loading, copy from dest to src
        src="$dest"
        dest="$HOME/$1"
    else
        # When updating, copy from src to dest
        src="$HOME/$1"
    fi

    # Remove destination if it exists
    rm -rf "$dest"

    # Check if the source is a directory
    if [ -d "$src" ]; then
        mkdir -p "$(dirname "$dest")"
        cp -r "$src" "$dest"
    elif [ -f "$src" ]; then
        mkdir -p "$(dirname "$dest")"
        cp "$src" "$dest"
    fi
}

update=false
load=false

while [[ $# -gt 0 ]]; do
    case "$1" in
    -u | --update)
        update=true
        shift
        ;;
    -l | --load)
        load=true
        shift
        ;;
    *)
        echo "Invalid option: $1"
        exit 1
        ;;
    esac
done

if [ "$update" = true ]; then
    echo "Updating dotfiles..."
    copy ".config/alacritty/alacritty.toml"
    copy ".config/bat/themes/"
    copy ".config/btop/btop.conf"
    copy ".config/btop/themes/"
    copy ".config/Code/User/settings.json"
    copy ".config/Code/User/keybindings.json"
    copy ".config/fastfetch/"
    copy ".config/fish/config.fish"
    copy ".config/ghostty/config"
    copy ".config/kitty/"
    copy ".config/lazygit/config.yml"
    copy ".config/nvim/"
    copy ".config/starship.toml"
    copy ".config/tealdeer/config.toml"
    copy ".config/yazi/init.lua"
    copy ".config/yazi/keymap.toml"
    copy ".config/yazi/yazi.toml"
    copy ".config/yazi/theme.toml"
    copy ".config/yazi/rose-pine-theme.toml" # waiting for a flavor
    copy ".config/zathura/"
    copy ".config/zed/"
    copy ".ideavimrc"
elif [ "$load" = true ]; then
    echo "Load or overwrite dotfiles ..."
    copy ".config/alacritty/alacritty.toml"
    copy ".config/bat/themes/"
    copy ".config/btop/btop.conf"
    copy ".config/btop/themes/"
    copy ".config/Code/User/settings.json"
    copy ".config/Code/User/keybindings.json"
    copy ".config/fastfetch/"
    copy ".config/fish/config.fish"
    copy ".config/ghostty/config"
    copy ".config/kitty/"
    copy ".config/lazygit/config.yml"
    # copy ".config/nvim/"
    copy ".config/starship.toml"
    copy ".config/tealdeer/config.toml"
    copy ".config/yazi/init.lua"
    copy ".config/yazi/keymap.toml"
    copy ".config/yazi/yazi.toml"
    copy ".config/yazi/theme.toml"
    copy ".config/yazi/rose-pine-theme.toml" # waiting for a flavor
    copy ".config/zathura/"
    copy ".config/zed/"
    copy ".ideavimrc"
else
    echo "You must specify either -u/--update or -l/--load."
    exit 1
fi
