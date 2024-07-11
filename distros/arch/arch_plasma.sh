#!/bin/bash

# Color Definitions
RED='\033[0;31m'        # Errors
ORANGE='\033[0;33m'     # System information / Title
YELLOW='\033[1;33m'     # Packages
GREEN='\033[0;32m'      # Success
LIGHTBLUE='\033[1;34m'  # Configs
NC='\033[0m'            # No Color (reset to default value)

# ------------------------------------- Plasma --------------------------------
# Remove undesired preinstalled plasma applications

apps_to_remove=(
    kate
    vim
    plasma-browser-integration
    xterm
    stoken
)

for app in "${apps_to_remove[@]}"; do
    echo -e "${YELLOW}\n\nRemoving$app...${NC}"
    sudo pacman -Rdduns "$app" --noconfirm
done

# ------------------------------------- Terminal tools ------------------------
apps=(
    # Terminal tools
    "qt5-graphicaleffects"  # Required for the SDDM themes
    "wl-clipboard"          # Required for neovim to copy to clipboard

    # GUI tools
    "filelight"                 # Disk usage analyzer
    "gnome-disk-utility"        # Disk tool (partitioning etc)
    "gwenview"                  # Image viewer
    "kamoso"                    # Camera
    "kolourpaint"               # Like MS Paint for KDE
    # "lutris"                  # Windows game engine (requires wine)
    "meld"                      # Compare multiple files
    "okular"                    # Document viewer (qt based)
    # "piper"                   # Logitech mouse support
    # "prismlauncher"           # Minecraft launcher
    "python-pympress"           # A PDF presenter
    "qalculate-qt"              # Advanced GUI (qt) and Terminal calculator
    "resources"                 # System monitor
    "seahorse"                  # Token manager
    "spotify"                   # Spotify for Linux
    "spotube-bin"               # combines the power of spotify and youtube
    "teams-for-linux"           # Teams client for Linux
    "transmission-qt"           # Torrent downloader
    "vlc"                       # Video player
    "zapzap"                    # qt6 based Whatsapp client for Linux
)

for app in "${apps[@]}"; do
    echo -e "${YELLOW}\n\nInstalling $app...${NC}"
    paru -S "$app" --noconfirm
done

# ------------------------------------- Other ---------------------------------
# Remove kwalletrc (You must logout and enter no password at next login)
rm -rf ~/.local/share/kwalletd/*  ~/.config/kwalletrc

# ------------------------------------- Cleanup cache -------------------------
yay -Scc
