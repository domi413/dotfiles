#!/bin/bash

# Color Definitions
RED='\033[0;31m'        # Errors
ORANGE='\033[0;33m'     # System information / Title
YELLOW='\033[1;33m'     # Packages
GREEN='\033[0;32m'      # Success
LIGHTBLUE='\033[1;34m'  # Configs
NC='\033[0m'            # No Color (reset to default value)

# ------------------------------------- update packages ------------------------
echo -e "${YELLOW}\n\nUpdating packages...${NC}"
sudo pacman -Syu --noconfirm

# ------------------------------------- Create home directory -----------------
echo -e "${LIGHTBLUE}\n\nCreating home directories...${NC}"
mkdir -p ~/Desktop
mkdir -p ~/Documents
mkdir -p ~/Downloads
mkdir -p ~/Music
mkdir -p ~/Pictures
mkdir -p ~/Videos

# ------------------------------------- AUR-helper (yay) ----------------------
sudo pacman -S yay --noconfirm

# ------------------------------------- Terminal tools ------------------------
apps=(
    # Terminal
    "kitty"                 # Terminal that runs in the GPU

    # Terminal tools
    "bat"                   # Better cat alternative with syntax highlighting
    "eza"                   # Colorful ls
    "fish"                  # zsh-shell for the lazy ones
    "git"                   # Distributed version control system
    "htop"                  # Terminal based system monitor
    "lazygit"               # Git interface for neovim
    "npm"                   # Node.js package manager, required for neovim (mason)
    "onedrive-abraunegg"    # OneDrive support
    "ripgrep-all"           # Ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, etc.
    "trash-cli"             # Control trash through terminal
    "zoxide"                # Better cd for faster file system navigation

    # Internet
    "firefox"                   # Firefox browser
    "teams-for-linux"           # Teams client for Linux
    "thunderbird"               # Thunderbird mail
    "spotify"                   # Spotify for Linux

    # Editors
    # "intellij-idea-ultimate-edition"    # Intellij
    "neovim"                            # Neovim
    "visual-studio-code-bin"            # VSCode
    # "vscodium"                        # VSCode with better privacy
    # "vscodium-git-marketplace"        # VSCodium with vscode marketplace

    # Wine
    # "wine"
    # "wine-gecko"
    # "wine-mono"

    # Programming languages
    # "gcc"
    "clang"
    "jdk-openjdk"
    # "python"

    # Latex
    "texstudio"
    "texlive"               # LaTeX compiler and libraries
    "texlive-lang"         

    # Office
    "libreoffice-still"     # LibreOffice productivity suite (still version)
    "hyphen-de"             # German hyphenation rules

    # Fun applications
    "asciiquarium-transparent-git"      # IS THIS A SHARK?
    "cmatrix"                           # Matrix-like screen saver (makes you look like a hacker)
    "cowsay"                            # Configurable talking cow
    "fortune-mod"                       # Prints a random, hopefully interesting, adage
    "fastfetch"                         # Fast, highly customizable system info script
    "nyancat"                           # FUCKING NYANCAT
)

for app in "${apps[@]}"; do
    echo -e "${YELLOW}\n\nInstalling $app...${NC}"
    yay -S "$app" --noconfirm
done

# ------------------------------------- fonts ---------------------------------
font_links=(
    https://github.com/pjobson/Microsoft-365-Fonts
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Lilex.zip
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip
    # https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/NerdFontsSymbolsOnly.zip
)

for font in "${font_links[@]}"; do
    if [[ "$font" == *.zip ]]; then
        repo_name=$(basename "$font")
        echo -e "${YELLOW}\n\nDownloading $font...${NC}"
        
        download_path="$HOME/Downloads/$repo_name"

        wget -O "$download_path" "$font"
        unzip -o -d "$HOME/Downloads/${repo_name%.*}" "$download_path"

        move_path="$HOME/Downloads/${repo_name%.*}"
    else
        repo_name=$(basename "${font%/*}")  # Removes the last part of URL if it's not a .git repository
        
        echo -e "${YELLOW}\n\nCloning $font into $HOME/Downloads/$repo_name...${NC}"
        
        # Clone the repository
        git clone --depth 1 "$font" "$HOME/Downloads/$repo_name" 2>/dev/null || echo -e "${RED}Failed to clone $font. Check if the URL is a full repository.${NC}"

        move_path="$HOME/Downloads/${repo_name%.*}"
    fi

    echo -e "${YELLOW}\n\nMoving fonts to /usr/share/fonts/${NC}"
    sudo cp -r "$move_path" /usr/share/fonts/
done

echo -e "${GREEN}\n\nInstalled fonts${NC}"

# ------------------------------------- KVM with QEMU -------------------------
configure_and_start_services() {
    set +e
    
    echo -e "${GREEN}\nConfiguring and starting necessary services...${NC}"
    
    # Start and enable libvirtd.service
    echo -e "${YELLOW}\nStarting and enabling libvirtd.service...${NC}"
    sudo systemctl start libvirtd.service
    sudo systemctl enable libvirtd.service
    
    # Manage the 'default' network
    manage_default_network
    
    set -e
}

manage_default_network() {
    defaultNetworkActive=$(sudo virsh net-list --all | grep -w default | grep -w active)
    
    echo -e "${YELLOW}\nThe 'default' network is not active. Starting it...${NC}"
    sudo virsh net-start default
    
    # defaultNetworkAutostart=$(sudo virsh net-list --all | grep -w default | grep -w yes)
    
    echo -e "${YELLOW}\nSetting the 'default' network to autostart...${NC}"
    sudo virsh net-autostart default
    
    # Finally, list all networks to confirm their statuses
    echo -e "${GREEN}\nCurrent network list:${NC}"
    sudo virsh net-list --all
}

echo -e "${YELLOW}\n\nInstalling KVM...${NC}"
sudo pacman -S virt-manager qemu-full vde2 dnsmasq bridge-utils openbsd-netcat --noconfirm
configure_and_start_services

# ------------------------------------- Start KVM -----------------------------
set +e
echo -e "${ORANGE}\nConfiguring and starting necessary services...${NC}"

# Start and enable libvirtd.service
echo -e "${LIGHTBLUE}\nStarting and enabling libvirtd.service...${NC}"
sudo systemctl start libvirtd.service
sudo systemctl enable libvirtd.service

# Check the 'default' network status more reliably
defaultNetworkActive=$(sudo virsh net-list --all | grep -w default | grep -w active)

if [ -z "$defaultNetworkActive" ]; then
    echo -e "${LIGHTBLUE}\nThe 'default' network is not active. Starting it...${NC}"
    sudo firewall-cmd --reload
    sudo virsh net-start default
else
    echo -e "${ORANGE}\nThe 'default' network is already active.${NC}"
fi

# Ensure the 'default' network is set to autostart
defaultNetworkAutostart=$(sudo virsh net-list --all | grep -w default | grep -w yes)

if [ -z "$defaultNetworkAutostart" ]; then
    echo -e "${LIGHTBLUE}\nSetting the 'default' network to autostart...${NC}"
    sudo virsh net-autostart default
else
    echo -e "${ORANGE}\nThe 'default' network is already set to autostart.${NC}"

#-------------------------------------- SpotX (ad-blocker) --------------------
echo -e "${YELLOW}\n\nInstalling SpotX...${NC}"
bash <(curl -sSL https://spotx-official.github.io/run.sh) -f # -f -> force rerun if already tried

# ------------------------------------- Bluetooth -----------------------------
sudo modprobe btusb
pacman -Ss bluetooth
sudo dmesg | grep -i bluetooth

# Start bluetooth deamon
sudo systemctl start bluetooth
sudo systemctl enable bluetooth
sudo systemctl status bluetooth

# ------------------------------------- Printer manager -----------------------
# echo -e "${YELLOW}\n\nInstalling CUPS...${NC}"
sudo pacman -S cups --noconfirm

sudo systemctl start cups.service
sudo systemctl enable cups.service

# install printer gui
# sudo pacman -S system-config-printer

# Restart avahi 
sudo systemctl restart avahi-daemon

# ------------------------------------- enable WLAN ---------------------------
# sudo systemctl enable --now NetworkManager

# ------------------------------------- Firefox extensions---------------------
# Go to https://addons.mozilla.org/en-US/firefox/
# and search for a plugin you want to install.
# Right-click the "Add to Firefox"-Button and copy link

# To get the plugin ID:
#   - go to about:memory
#   - under "Show memory reports" -> Measure
#   - Search for "moz-extension"
#
#
#   Configure to open popup in same tab group:
#       -> go to about:config
#       -> search for browser.link.open_newwindow
#       -> set value to 3
#           1 = current tab
#           2 = new window
#           3 = new tab

echo -e "${YELLOW}\n\nInstalling Firefox plugins...${NC}"

# Define extension URLs and their IDs
declare -A extensions=(
    ["{762f9885-5a13-4abd-9c77-433dcd38b8fd}"]="https://addons.mozilla.org/firefox/downloads/file/4208483/return_youtube_dislikes-3.0.0.14.xpi"
    ["{c3348e96-6d84-47dc-8252-4b8493299efc}"]="https://addons.mozilla.org/firefox/downloads/file/3975526/nyan_cat_youtube_enhancement-3.0.xpi"
    ["{446900e4-71c2-419f-a6a7-df9c091e268b}"]=https://addons.mozilla.org/firefox/downloads/file/4307738/bitwarden_password_manager-2024.6.3.xpi
    ["vimium-c@gdh1995.cn"]="https://addons.mozilla.org/firefox/downloads/file/4210117/vimium_c-1.99.997.xpi"
    ["addon@darkreader.org"]="https://addons.mozilla.org/firefox/downloads/file/4249607/darkreader-4.9.80.xpi"
    ["uBlock0@raymondhill.net"]="https://addons.mozilla.org/firefox/downloads/file/4237670/ublock_origin-1.56.0.xpi"
    ["widegpt@cstone"]="https://addons.mozilla.org/firefox/downloads/file/4224810/widegpt-1.14.xpi"
)

# Ensure the Firefox distribution extensions directory exists
firefox_dist_path="/lib/firefox/distribution/extensions" && sudo mkdir -p "$firefox_dist_path"

for id in "${!extensions[@]}"; do
    url="${extensions[$id]}"
    file_name=$(basename "$url")
    save_path="$firefox_dist_path/$id.xpi"
    echo "Downloading and installing $file_name with ID $id"
    # Download the .xpi file using its ID as the file name
    sudo wget -O "$save_path" "$url" && echo "Installed $file_name to $save_path"
done

echo -e "${GREEN}\nAll extensions have been downloaded and extracted.${NC}"


# ------------------------------------- Texstudio language packs --------------
# Download the english and swiss german spellchecker
dict_links=(
    https://extensions.libreoffice.org/assets/downloads/z/dict-de-ch-frami-2017-01-12.oxt
    https://extensions.libreoffice.org/assets/downloads/41/1711953562/dict-en-20240401_lo.oxt
)

for link in "${dict_links[@]}"; do
    dict_name=$(basename "$link")
    download_path="$HOME/Downloads/$dict_name"

    wget -O "$download_path" "$link"
    unzip -o -d "$HOME/Downloads/${dict_name%.*}" "$download_path"
done

# Ensure the target directories are empty before moving new files
sudo rm -rf /usr/share/texstudio/language/dict_en/*
sudo rm -rf /usr/share/texstudio/language/META-INF/*
sudo rm -rf /usr/share/texstudio/language/de_CH_frami/*
sudo rm -rf /usr/share/texstudio/language/hyph_de_CH/*
sudo rm -rf /usr/share/texstudio/language/thes_de_CH_v2/*
sudo mkdir -p /usr/share/texstudio/language/dict_en

# Copy english dict
sudo mv "$HOME/Downloads/dict-en-20240401_lo/"* /usr/share/texstudio/language/dict_en/
# Copy swiss german dict
sudo mv "$HOME/Downloads/dict-de-ch-frami-2017-01-12/"* /usr/share/texstudio/language/

# Clean download folder
find "$HOME/Downloads/" -name "dict-*" -exec rm -r {} +

# ------------------------------------- VSCode extensions ---------------------
# Check if vscode is installed
if command -v code &> /dev/null; then # use 'codium' if you want to use VSCodium
    editor="code"
    VSCODE_INSTALLED=1
else
    echo -e "${RED}\nVSCode is not installed.${NC}"
    VSCODE_INSTALLED=0
fi

# You can add additional plugins from:
# https://marketplace.visualstudio.com/vscode

# If you want to use vscodium, you have to use packages from the following
# open source registry: https://open-vsx.org/
# or you update the marketplace to vscode marketplace (which is not recommended)

plugins=(
    "akamud.vscode-theme-onelight"
    "albert.TabOut"
    "Codeium.codeium"
    "James-Yu.latex-workshop"
    "mads-hartmann.bash-ide-vscode"
    "ms-python.debugpy"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-vscode.cpptools"
    # "MS-vsliveshare.vsliveshare"
    "mvllow.rose-pine"
    "njzy.stats-bar"
    # "platformio_x64"
    "redhat.java"
    "tomoki1207.pdf"
    "VisualStudioExptTeam.vscodeintellicode"
    "vscjava.vscode-java-debug"
    "vscjava.vscode-java-test"
    "vscjava.vscode-maven"
)

echo -e "${YELLOW}\n\nInstalling VS Code plugins...${NC}"

# Maximum number of installation attempts
max_attempts=3

if [ $VSCODE_INSTALLED -eq 1 ]; then
    for plugin in "${plugins[@]}"; do
        attempt=1
        while [ $attempt -le $max_attempts ]; do
            echo -e "\nAttempting to install $plugin, attempt $attempt of $max_attempts..."
            if $editor --install-extension $plugin; then
                echo -e "${GREEN}Successfully installed $plugin.${NC}"
                break
            else
                echo -e "${RED}Failed to install $plugin. Retrying in 1 seconds...${NC}"
                sleep 1
            fi
            ((attempt++))
        done
        if [ $attempt -gt $max_attempts ]; then
            echo -e "${RED}Failed to install $plugin after $max_attempts attempts.${NC}"
        fi
    done
fi

# ------------------------------------- Configure Git -------------------------
set +e

echo -e "${ORANGE}\n\nPlease configure Git user name and email:${NC}"

# Check if a Git user name is already set
existingGitUserName=$(git config --global user.name)
if [ -n "$existingGitUserName" ]; then
    echo "Current Git user name is: $existingGitUserName"
    read -p "Do you want to keep this user name? (y/n): " keepUserName

    if [ "$keepUserName" != "y" ]; then
        read -p "Enter new Git user name: " gitUserName
        git config --global user.name "$gitUserName"
    fi
else
    read -p "Enter Git user name: " gitUserName
    git config --global user.name "$gitUserName"
fi

# Check if a Git email is already set
existingGitEmail=$(git config --global user.email)
if [ -n "$existingGitEmail" ]; then
    echo "Current Git email is: $existingGitEmail"
    read -p "Do you want to keep this email? (y/n): " keepEmail

    if [ "$keepEmail" != "y" ]; then
        read -p "Enter new Git email: " gitEmail
        git config --global user.email "$gitEmail"
    fi
else
    read -p "Enter Git email: " gitEmail
    git config --global user.email "$gitEmail"
fi

set -e

# ------------------------------------- Cleanup cache -------------------------
yay -Scc --noconfirm

# ------------------------------------- change shell --------------------------
chsh -s /bin/fish