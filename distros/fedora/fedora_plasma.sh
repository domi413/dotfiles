#!/bin/bash

# *****************************************************************************
# Troubleshooting:
#
# Disabling KDEWallet password:
#   1. Enter this command: rm -rf ~/.local/share/kwalletd/*  ~/.config/kwalletrc
#   2. Logout
#   3. Enter empty password
#

# ------------------------------------- configs -------------------------------
# Color Definitions
RED='\033[0;31m'        # Errors
ORANGE='\033[0;33m'     # System information / Title
YELLOW='\033[1;33m'     # Packages
GREEN='\033[0;32m'      # Success
LIGHTBLUE='\033[1;34m'  # Configs
NC='\033[0m'            # No Color (reset to default value)

remove_package() {
    local package=$1
    sudo dnf remove "$package" -y || true
}

install_package() {
    local package="$1"
    sudo dnf install -y "$package"
}

# ------------------------------------- Terminal tools ------------------------
apps_to_install=(
    # GUI tools
    "filelight"                    # Disk usage analyzer
    "gnome-disk-utility"        # Disk tool (partitioning etc)
    "gwenview"                  # Image viewer
    "kamoso"                    # Camera
    "kolourpaint"               # Like MS Paint for KDE
    # "lutris"                  # Windows game engine (requires wine)
    "meld"                      # Compare multiple files
    "okular"                    # Document viewer (qt based)
    # "piper"                   # Logitech mouse support
    "qalculate-qt"              # Advanced GUI (qt) and Terminal calculator
    # "seahorse"                  # Token manager
    "transmission-qt"           # Torrent downloader
    "vlc"                       # Video player
)

# Loop over the list and install each application
for app in "${apps_to_install[@]}"; do
    install_package "$app"
done

### ---------------------------------------------------------------------------
### ----------------------------------- copr ----------------------------------
### ---------------------------------------------------------------------------

# ------------------------------------- Intellij ------------------------------
sudo dnf copr enable coder966/intellij-idea-ultimate
sudo dnf install intellij-idea-ultimate

# ------------------------------------- Whatsapp client -----------------------
sudo dnf copr enable rafatosta/zapzap 
sudo dnf install zapzap

# ------------------------------------- Remove bullshit aps --------------------
remove_apps=(
    "plasma-discover"
    "konsole"
    "akregator"
    "dragon"
    "plasma-systemmonitor"
    "elisa-player"
    "im-chooser"
    "kaddressbook"
    "kcalc"
    "kcharselect"
    "kpartx"
    "kde-partitionmanager"
    "kde-connect"
    "kmahjongg"
    "kmail"
    "kmines"
    "kmouth"
    "kmousetool"
    "korganizer"
    "kpat"
    "krfb"
    "skanpage"
    "libreoffice-*"
    "krdc"
    "neochat"
    "kwrite"
    "plasma-welcome"
    "khelpcente"
    "mediawriter"
)
for app in "${remove_apps[@]}"; do
    remove_package "$app"
done

# ------------------------------------- Other ---------------------------------
# Remove kwalletrc (You must logout and enter no password at next login)
# rm -rf ~/.local/share/kwalletd/*  ~/.config/kwalletrc

# ------------------------------------- Update lpf packages -------------------
lpf update

# ------------------------------------- Cleanup cache -------------------------
sudo dnf clean all