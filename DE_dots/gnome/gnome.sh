#!/bin/bash

# ------------------------------------- configs -------------------------------
# Color Definitions
RED='\033[0;31m'        # Errors
ORANGE='\033[0;33m'     # System information / Title
YELLOW='\033[1;33m'     # Packages
GREEN='\033[0;32m'      # Success
BLUE='\033[0;34m'       # Installation
LIGHTBLUE='\033[1;34m'  # Configs
NC='\033[0m' # No Color

# Set the directory where the keybinding files are stored
keybinding_dir="./"  # assuming the current directory, adjust as necessary

# Load Gnome WM keybindings if available
if [ -f "${keybinding_dir}gnome_wm_keybindings.txt" ]; then
    dconf load /org/gnome/desktop/wm/keybindings/ < "${keybinding_dir}gnome_wm_keybindings.txt"
    echo -e "${GREEN}Gnome WM keybindings loaded.${NC}"
else
    echo -e "${RED}Gnome WM keybindings file not found.${NC}"
fi

# Load Gnome media keys if available
if [ -f "${keybinding_dir}gnome_media_keys.txt" ]; then
    dconf load /org/gnome/settings-daemon/plugins/media-keys/ < "${keybinding_dir}gnome_media_keys.txt"
    echo -e "${GREEN}Gnome media keys loaded.${NC}"
else
    echo -e "${RED}Gnome media keys file not found.${NC}"
fi
