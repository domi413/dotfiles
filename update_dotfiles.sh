#!/bin/bash

TARGET_DIR=$(pwd)

copy() {
    local src="$HOME/$1"
    local dest_dir="${1#\.config/}"
    local dest="$TARGET_DIR/$dest_dir"

    # Check if the source is a directory
    if [ -d "$src" ]; then
        mkdir -p "$dest"
        rsync -a "$src/" "$dest/"
    elif [ -f "$src" ]; then
        mkdir -p "$(dirname "$dest")"
        rsync -a "$src" "$dest"
    fi
}

# Add specific files to the dotfiles
copy ".config/alacritty/alacritty.toml"
copy ".config/bat/themes/"
copy ".config/btop/btop.conf"
copy ".config/btop/themes/"
copy ".config/Code/User/settings.json"
copy ".config/Code/User/keybindings.json"
copy ".config/fastfetch/"
copy ".config/fish/config.fish"
copy ".config/kitty/"
copy ".config/lazygit/config.yml"
copy ".config/nvim/"
copy ".config/starship.toml"
copy ".config/tealdeer/config.toml"
copy ".config/yazi/init.lua"
copy ".config/yazi/keymap.toml"
copy ".config/yazi/yazi.toml"
copy ".config/yazi/theme.toml"
copy ".config/yazi/package.toml"
copy ".config/yazi/rose-pine-theme.toml" # waiting for a flavor
copy ".config/zathura/"
copy ".config/zed/"
copy ".ideavimrc"

echo -e "\033[32mAll specified files and directories have been copied to $TARGET_DIR.\033[0m"
