#!/bin/bash

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
    "clapper"                   # GTK 4 video player
    "dconf-editor"              # Advanced gnome GUI config
    "gnome-tweaks"              # Edit gnome
    "meld"                      # Compare multiple files
    "qalculate-gtk"             # Advanced GUI (GTK) and Terminal calculator
    "transmission-gtk"          # Torrent downloader


    # Install the following through gnome store (flathub)
    # bitwarden
    # extension manager
    # gnome-papers
    # obsidian
    # teams
    # whatsapp (zapzap)

    # intellij (install manually from official intellij website)
)

# Loop over the list and install each application
for app in "${apps_to_install[@]}"; do
    install_package "$app"
done

### ---------------------------------------------------------------------------
### ----------------------------------- copr ----------------------------------
### ---------------------------------------------------------------------------

# ------------------------------------- Themes --------------------------------
# Bibata cursor
sudo dnf copr enable peterwu/rendezvous
sudo dnf install bibata-cursor-themes

# Papirus icons
sudo dnf copr enable dirkdavidis/papirus-icon-theme 
sudo dnf install papirus-icon-theme

# ------------------------------------- Resourcers ----------------------------
sudo dnf copr enable atim/resources -y
sudo dnf install resources -y

# ------------------------------------- ripgrep-all ---------------------------
# >>> not working the same as on arch, e.g. rga-fzf not available
# sudo dnf copr enable returntrip/ripgrep-all -y
# sudo dnf install ripgrep-all -y

### ---------------------------------------------------------------------------
# ------------------------------------- nautilus-extensions -------------------
# >>> Use a link to gnome-terminal
# cd ~/Downloads
# git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git
# cd nautilus-open-any-terminal
# make
#
# make install schema      # User install
# sudo make install schema # System install
# nautilus -q # restart nautlius
#
# gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty

# the following configs aren't working (?)
# gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings '<Ctrl><Alt>t'
# gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true
# gsettings set com.github.stunkymonkey.nautilus-open-any-terminal flatpak system

# >>> symlink alternative
sudo mv /usr/bin/gnome-terminal /usr/bin/gnome-terminal.bak
sudo ln -s /usr/bin/kitty /usr/bin/gnome-terminal

# -----------------------------------------------------------------------------
cd ~/Downloads/
git clone https://github.com/ronen25/nautilus-copypath
cd nautilus-copypath

mkdir ~/.local/share/nautilus-python
mkdir ~/.local/share/nautilus-python/extensions
cp nautilus-copypath.py ~/.local/share/nautilus-python/extensions/

nautilus -q

# ------------------------------------- GNOME Extensions ----------------------
# Blur my Shell
# Caffeine
# Color Picker
# Dash to Deck
# Lock screen Background ?
# Unblank lock screen ?
# Vitals

# ------------------------------------- Remove bullshit aps --------------------
remove_apps=(
    "abrt"
    "evince"
    "gnome-boxes"
    "gnome-calculator"
    "gnome-connections"
    "gnome-contacts"
    "gnome-font-viewer"
    "gnome-logs"
    "gnome-maps"
    # "gnome-system-monitor" # can't be deleted because hardcoded dependencies for default terminal...
    "gnome-text-editor"
    "gnome-tour"
    "mediawriter"
    "simple-scan"
    "rhythmbox"
    "totem"
    "yelp"
)
for app in "${remove_apps[@]}"; do
    remove_package "$app"
done

# ------------------------------------- Cleanup cache -------------------------
sudo dnf clean all