#!/bin/bash

# ------------------------------------- configs -------------------------------
# Color Definitions
RED='\033[0;31m'        # Errors
ORANGE='\033[0;33m'     # System information / Title
YELLOW='\033[1;33m'     # Packages
GREEN='\033[0;32m'      # Success
LIGHTBLUE='\033[1;34m'  # Configs
NC='\033[0m'            # No Color (reset to default value)

# ------------------------------------- Create home directory -----------------
echo -e "${LIGHTBLUE}\n\nCreating home directories...${NC}"
mkdir -p ~/Desktop
mkdir -p ~/Documents
mkdir -p ~/Downloads
mkdir -p ~/Music
mkdir -p ~/Pictures
mkdir -p ~/Videos

update_packages() {
    echo -e "${YELLOW}Updating packages using dnf...${NC}"
    sudo dnf upgrade --refresh -y
}

install_package() {
    local package="$1"
    sudo dnf install -y "$package"
}

# ------------------------------------- update packages -----------------------¨
echo -e "${YELLOW}Updating packages...${NC}"
update_packages

# ------------------------------------- Terminal tools ------------------------
apps_to_install=(
    # Terminal
    "kitty"                 # A GPU driven terminal

    # Terminal tools
    "bat"                   # Better cat alternative with syntax highlighting
    "dnf-utils"             # Some terminal commands/tools
    "eza"                   # Colorful ls
    "fish"                  # zsh-shell for the lazy ones
    "git"                   # Distributed version control system
    "htop"                  # Terminal based system monitor
    "npm"                   # Node.js package manager, required for neovim
    "trash-cli"             # Control trash through terminal
    "wl-clipboard"          # Required for neovim to copy to clipboard
    "zoxide"                # Better cd for faster file system navigation

    # Browser
    "firefox"       # Firefox browser

    # Mail
    "thunderbird"   # Thunderbird mail

    # Languages
    "clang"
    "gcc"
    "gdb"
    "java-latest-openjdk.x86_64"

    # Latex
    "texstudio"                 # LaTeX IDE
    # "texlive-scheme-full"     # Full LaTeX environment
    "texlive-scheme-medium"     # medium LaTeX environment
    # "texlive-scheme-basic"    # basic LaTeX environment

    # Office
    # "libreoffice"         # LibreOffice productivity suite (still version)
    "libreoffice-writer"    # Word
    "libreoffice-calc"      # Excel
    "libreoffice-impress"   # Powerpoint
    "hyphen-de"             # German hyphenation rules

    # Fun applications
    "asciiquarium"          # IS THIS A SHARK
    "cmatrix"               # Matrix-like screen saver
    "cowsay"                # Configurable talking cow
    "fortune-mod"           # Prints a random, hopefully interesting, adage
    "fastfetch"             # Fast, highly customizable system info script
    "nyancat"               # Animated Nyancat in your terminal
    "onedrive"              # Onedrive client

    # Editor
    "neovim"

    # Wine
    # "wine"
)

# Loop over the list and install each application
for app in "${apps_to_install[@]}"; do
    install_package "$app"
done

# ------------------------------------- fonts ---------------------------------
font_links=(
    https://github.com/pjobson/Microsoft-365-Fonts
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Lilex.zip
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip
    # https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/NerdFontsSymbolsOnly.zip
)

for link in "${font_links[@]}"; do
    if [[ "$link" == *.zip ]]; then
        repo_name=$(basename "$link")
        echo -e "${YELLOW}\n\nDownloading $link...${NC}"
        
        download_path="$HOME/Downloads/$repo_name"

        wget -O "$download_path" "$link"
        unzip -o -d "$HOME/Downloads/${repo_name%.*}" "$download_path"

        move_path="$HOME/Downloads/${repo_name%.*}"
    else
        repo_name=$(basename "${link%/*}")  # Removes the last part of URL if it's not a .git repository
        
        echo -e "${YELLOW}\n\nCloning $link into $HOME/Downloads/$repo_name...${NC}"
        
        # Clone the repository
        git clone --depth 1 "$link" "$HOME/Downloads/$repo_name" 2>/dev/null || echo -e "${RED}Failed to clone $link. Check if the URL is a full repository.${NC}"

        move_path="$HOME/Downloads/${repo_name%.*}"
    fi

    echo -e "${YELLOW}\n\nMoving fonts to /usr/share/fonts/${NC}"
    sudo cp -r "$move_path" /usr/share/fonts/
done

echo -e "${GREEN}\n\nInstalled fonts${NC}"

# ------------------------------------- Spotify -------------------------------
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y # Free software
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y # Non-Free software
sudo dnf install lpf-spotify-client -y

# You must run the spotx command manually after you have installed spotify
# bash <(curl -sSL https://spotx-official.github.io/run.sh) -f # -f -> force rerun if already tried

# -------------------------------------- Visual Studio Code -------------------
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'# # ------------------------------------- KVM with QEMU -------------------------

dnf check-update
sudo dnf install code # or code-insiders

# ------------------------------------- VSCodium ------------------------------
# sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
# echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
#
# dnf check-update
# sudo dnf install code # or code-insiders

### ---------------------------------------------------------------------------
### ----------------------------------- copr ----------------------------------
### ---------------------------------------------------------------------------

# ------------------------------------- LazyGit -------------------------------
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit

# ------------------------------------- Pympress ------------------------------
sudo dnf copr enable cimbali/pympress -y
sudo dnf install python3-pympress -y

# ------------------------------------- Resourcers ----------------------------
sudo dnf copr enable atim/resources -y
sudo dnf install resources -y

# ------------------------------------- ripgrep-all ---------------------------
# >>> not working the same as on arch, e.g. rga-fzf not available
# sudo dnf copr enable returntrip/ripgrep-all -y
# sudo dnf install ripgrep-all -y

# ------------------------------------- KVM with QEMU -------------------------
# configure_and_start_services() {
#     set +e
#     
#     echo -e "${GREEN}\nConfiguring and starting necessary services...${NC}"
#     
#     # Start and enable libvirtd.service
#     echo -e "${YELLOW}\nStarting and enabling libvirtd.service...${NC}"
#     sudo systemctl start libvirtd.service
#     sudo systemctl enable libvirtd.service
#     
#     # Manage the 'default' network
#     manage_default_network
#     
#     set -e
# }
#
# manage_default_network() {
#     defaultNetworkActive=$(sudo virsh net-list --all | grep -w default | grep -w active)
#     
#     if [ -z "$defaultNetworkActive" ]; then
#         echo -e "${YELLOW}\nThe 'default' network is not active. Starting it...${NC}"
#         sudo virsh net-start default
#     else
#         echo -e "${GREEN}\nThe 'default' network is already active.${NC}"
#     fi
#     
#     defaultNetworkAutostart=$(sudo virsh net-list --all | grep -w default | grep -w yes)
#     
#     if [ -z "$defaultNetworkAutostart" ]; then
#         echo -e "${YELLOW}\nSetting the 'default' network to autostart...${NC}"
#         sudo virsh net-autostart default
#     else
#         echo -e "${GREEN}\nThe 'default' network is already set to autostart.${NC}"
#     fi
#     
#     # Finally, list all networks to confirm their statuses
#     echo -e "${GREEN}\nCurrent network list:${NC}"
#     sudo virsh net-list --all
# }
#
# echo -e "${YELLOW}\n\nInstalling KVM...${NC}"
# install_package virt-manager qemu-kvm vde2 ebtables dnsmasq bridge-utils netcat
# configure_and_start_services
#
# # ------------------------------------- Start KVM -----------------------------
# set +e
# echo -e "${ORANGE}\nConfiguring and starting necessary services...${NC}"
#
# # Start and enable libvirtd.service
# echo -e "${LIGHTBLUE}\nStarting and enabling libvirtd.service...${NC}"
# sudo systemctl start libvirtd.service
# sudo systemctl enable libvirtd.service
#
# # Check the 'default' network status more reliably
# defaultNetworkActive=$(sudo virsh net-list --all | grep -w default | grep -w active)
#
# if [ -z "$defaultNetworkActive" ]; then
#     echo -e "${LIGHTBLUE}\nThe 'default' network is not active. Starting it...${NC}"
#     sudo firewall-cmd --reload
#     sudo virsh net-start default
# else
#     echo -e "${ORANGE}\nThe 'default' network is already active.${NC}"
# fi
#
# # Ensure the 'default' network is set to autostart
# defaultNetworkAutostart=$(sudo virsh net-list --all | grep -w default | grep -w yes)
#
# if [ -z "$defaultNetworkAutostart" ]; then
#     echo -e "${LIGHTBLUE}\nSetting the 'default' network to autostart...${NC}"
#     sudo virsh net-autostart default
# else
#     echo -e "${ORANGE}\nThe 'default' network is already set to autostart.${NC}"
# fi
#
# # Finally, list all networks to confirm their statuses
# echo -e "${ORANGE}\nCurrent network list:${NC}"
# sudo virsh net-list --all
#
# set -e
#
# echo -e "${GREEN}\nKVM configured and started.${NC}"

# ------------------------------------- Firefox plugins -----------------------
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
firefox_dist_path="/lib64/firefox/distribution/extensions" && sudo mkdir -p "$firefox_dist_path"

# Loop through the extensions array and process each item
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

# ------------------------------------- Update lpf packages -------------------
lpf update

# ------------------------------------- Cleanup cache -------------------------
sudo dnf clean all

# ------------------------------------- change shell --------------------------
chsh -s /bin/fish
