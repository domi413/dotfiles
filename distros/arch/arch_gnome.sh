#!/bin/bash

# Color Definitions
RED='\033[0;31m'        # Errors
ORANGE='\033[0;33m'     # System information / Title
YELLOW='\033[1;33m'     # Packages
GREEN='\033[0;32m'      # Success
LIGHTBLUE='\033[1;34m'  # Configs
NC='\033[0m'            # No Color (reset to default value)

# Remove undesired preinstalled gnome applications

apps_to_remove=(
    xterm
    gnome-text-editor
    gnome-power-manager
    gnome-usage
    gnome-calculator
    gnome-system-monitor
    stoken
)

for tool in "${apps_to_remove[@]}"; do
    echo -e "${YELLOW}\n\nRemoving$tool...${NC}"
    sudo pacman -Rdduns "$tool" --noconfirm
done

# ------------------------------------- Terminal tools ------------------------
apps=(
    # Terminal tools
    # "gnome-menus"           # To enable menu

    # GUI tools
    # "cheese"                  # Camera (maybe snapshot is the better option)
    "extension-manager"         # Install gnome extensions
    # "lutris"                  # Windows game engine (requires wine)
    "meld"                      # Compare multiple files
    "piper"                     # Logitech mouse support
    "python-pympress"           # PDF Presenter
    "qalculate-gtk"             # Advanced GUI (GTK) and Terminal calculator
    "resources"                 # Better system monitor
    "spotify"                   # Spotify for Linux
    "teams-for-linux"           # Teams client for Linux
    "transmission-gtk"          # Torrent downloader
    "zapzap"                    # qt6 based Whatsapp client for Linux

    # Themes
    "papirus-folders"           # Folder color theme for papirus theme
    "papirus-icon-theme"
    "bibata-cursor-theme"       # Bibata cursors
)

for tool in "${apps[@]}"; do
    echo -e "${YELLOW}\n\nInstalling $tool...${NC}"
        paru -S "$tool" --noconfirm
done


# ------------------------------------- advanced touchpad support -------------
# sudo pacman -S touchegg --noconfirm
# systemctl enable touchegg.service
# systemctl start touchegg.service

# ------------------------------------- Cleanup cache -------------------------
yay -Scc --noconfirm