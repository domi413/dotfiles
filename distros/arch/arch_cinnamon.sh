#!/bin/bash

# Color Definitions
RED='\033[0;31m'        # Errors
ORANGE='\033[0;33m'     # System information / Title
YELLOW='\033[1;33m'     # Packages
GREEN='\033[0;32m'      # Success
LIGHTBLUE='\033[1;34m'  # Configs
NC='\033[0m'            # No Color (reset to default value)

# Remove undesired preinstalled cinnamon applications
apps_to_remove=(
    xreader
    stoken
    xterm
    gnome-terminal
    galculator
    mpv
    xed
    gnome-system-monitor
)

for tool in "${apps_to_remove[@]}"; do
    echo -e "${YELLOW}\n\nRemoving$tool...${NC}"
    sudo pacman -Rdduns "$tool" --noconfirm
done

# ------------------------------------- Terminal tools ------------------------
apps=(
    # Terminal
    "redshift-minimal"      # Nightlight for cinnamon 
    "xclip"                 # Required for neovim to copy to clipboard

    # GUI tools
    "baobab-gtk3"               # Disk usage analyzer
    "bulky"                     # Multi file renamer (for nemo)
    # "cheese"                  # Camera (maybe snapshot is the better option)
    "evince"
    "gnome-disk-utility"        # Disk tool (partitioning etc)
    "gnome-screenshot"          # Screenshot tool
    # "gnome-system-monitor"    # System monitor
    "gthumb"                    # Image viewer
    # "lutris"                  # Windows game engine (requires wine)
    "indicator-sound-switcher"  # Applet to switch sound outputs
    "meld"                      # Compare multiple files
    "parole"                    # Simple video player
    "pinta"                     # Like MS Paint
    "piper"                     # Logitech mouse support
    "python-pympress"           # PDF Presenter
    "qalculate-gtk"             # Advanced GUI (GTK) and Terminal calculator
    "resources"                 # Better system monitor
    "seahorse"                  # Token manager
    "teams-for-linux"           # Teams client for Linux
    "transmission-gtk"          # Torrent downloader
    "whatsdesk-bin"             # Chat client

    # Theme
    "papirus-icon-theme"
    "beautyline"
    "dracula-gtk-theme"
    "papirus-folders"
    "bibata-cursor-theme"
)

for tool in "${apps[@]}"; do
    echo -e "${YELLOW}\n\nInstalling $tool...${NC}"
    yay -S "$tool" --noconfirm
done

# ------------------------------------- advanced touchpad support -------------
# sudo pacman -S touchegg --noconfirm
# systemctl enable touchegg.service
# systemctl start touchegg.service

# ------------------------------------- Papirus folder coloring ---------------
# set folder color to violet
papirus-folders -C violet --theme Papirus-Dark
sudo gtk-update-icon-cache /usr/share/icons/Papirus-Dark --noconfirm

echo -e "${GREEN}\nPapirus folder color successfully changed${NC}"

# ------------------------------------- Other ---------------------------------
# VS Code will overwrite default file explorer,
# this command will set nemo as default again
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

# The default terminal for gnome (based DE) is hard coded, to change the default
# terminal use following command
sudo ln -s /usr/bin/kitty /usr/bin/gnome-terminal


# Add bulky to nemo
mkdir -p "$HOME/.local/share/nemo/actions"
filename="bulky.nemo_action"

# Write the Nemo action configuration to a file
cat <<EOF >"$filename"
[Nemo Action]
Name=Bulk Rename with Bulky
Comment=Rename multiple files with Bulky
Exec=bulky %F
Icon-Name=bulky
Selection=Any
Extensions=any;
Dependencies=bulky;
EOF

mv "$filename" "$HOME/.local/share/nemo/actions"

echo -e "${GREEN}\n\nNemo action for Bulky has been created${NC}"

# ------------------------------------- Cleanup cache -------------------------
yay -Scc --noconfirm