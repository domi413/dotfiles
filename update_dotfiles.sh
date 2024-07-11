#!/bin/bash

TARGET_DIR=$(pwd)

# Copy a file or directory from the home directory to the current directory.
copy() {
    local src="$HOME/$1"
    local dest="$TARGET_DIR/$1"

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
copy ".config/Code/User/settings.json"
copy ".config/fish/config.fish"
copy ".config/kitty/kitty.conf"
copy ".config/texstudio/texstudio.ini"
copy ".config/indicator-sound-switcher.json"
copy ".ideavimrc"

# Add specific directories to the dotfiles
copy "Documents/Obsidian Vault/"
copy ".config/nvim/"

echo -e "\033[32mAll specified files and directories have been copied to $TARGET_DIR.\033[0m"
