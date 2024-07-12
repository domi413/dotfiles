#!/bin/bash
#
# following applications are missing yet:
#   - okular (keybindings)
#   - Panel settings
#
# Script to load plasma configs

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

keybinding_dir="$SCRIPT_DIR/keybindings"
image_dir="$SCRIPT_DIR/images"
config_dir="$SCRIPT_DIR/config"


# Load keybindings
# For KDE:
# cp ~/.config/kglobalshortcutsrc ~/backup_kglobalshortcutsrc.txt
# cp ~/.config/khotkeysrc ~/backup_khotkeysrc.txt
cp "${keybinding_dir}/kglobalshortcutsrc" "$HOME/.config/kglobalshortcutsrc"

# Copy images
cp -r ${image_dir}/* "$HOME/Pictures/"

# Load configs
cp -r ${config_dir}/* "$HOME/.config/"

echo "finished"
