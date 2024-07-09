#!/bin/bash

# Define the target directory as the current directory
TARGET_DIR=$(pwd)

# Function to copy a file or directory from the home directory to the current directory
copy() {
    local src="$HOME/$1"
    local dest="$TARGET_DIR/$1"

    # Check if the source is a directory to handle recursion and directory creation
    if [ -d "$src" ]; then
        # Ensure the destination directory exists and copy the entire directory
        mkdir -p "$dest"
        rsync -a "$src/" "$dest/"
    elif [ -f "$src" ]; then
        # Ensure the destination directory for the file exists
        mkdir -p "$(dirname "$dest")"
        # Copy the file, overwriting if it exists
        rsync -a "$src" "$dest"
    fi
}

# Copy specific files and entire directories as needed
copy ".config/alacritty/alacritty.toml"
copy ".config/Code/User/settings.json"
copy ".config/fish/config.fish"
copy ".config/kitty/kitty.conf"
copy ".config/nvim/"  # Copies all contents under nvim directory
copy ".config/qalculate/qalculate-gtk.cfg"
copy ".config/texstudio/texstudio.ini"
copy ".config/indicator-sound-switcher.json"
copy "Documents/Obsidian Vault/"  # Copies all contents of the Obsidian Vault directory
copy ".ideavimrc"

echo "All specified files and directories have been copied to $TARGET_DIR."
