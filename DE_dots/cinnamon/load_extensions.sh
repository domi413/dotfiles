#!/bin/bash
#
# Script to install Cinnamon Desklets, Applets, Themes and Extensions

# Directory where the downloads will be stored temporarily
DOWNLOAD_DIR="$HOME/Downloads/cinnamon-extensions"

# Ensure the download directory exists
mkdir -p "$DOWNLOAD_DIR"

# Array of URLs for the extensions
extension_links=(
    "https://cinnamon-spices.linuxmint.com/files/desklets/diskspace@schorschii.zip?time=1715722952"
    "https://cinnamon-spices.linuxmint.com/files/desklets/cpuload@kimse.zip?time=1715722952"
    "https://cinnamon-spices.linuxmint.com/files/desklets/SevenSegmentClock@lxs242.zip?time=1715722997"
    "https://cinnamon-spices.linuxmint.com/files/applets/qredshift@quintao.zip?time=1715723068"
    "https://cinnamon-spices.linuxmint.com/files/applets/color-picker@fmete.zip?time=1715723068"
    "https://cinnamon-spices.linuxmint.com/files/themes/qob.zip?time=1715723136"
    "https://cinnamon-spices.linuxmint.com/files/extensions/compiz-windows-effect@hermes83.github.com.zip?time=1715723190"
)

# Target directories for the types of extensions
declare -A target_dirs=(
    [desklets]="$HOME/.local/share/cinnamon/desklets"
    [applets]="$HOME/.local/share/cinnamon/applets"
    [themes]="$HOME/.themes"
    [extensions]="$HOME/.local/share/cinnamon/extensions"
)

# Ensure the target directories exist
mkdir -p "${target_dirs[desklets]}"
mkdir -p "${target_dirs[applets]}"
mkdir -p "${target_dirs[themes]}"
mkdir -p "${target_dirs[extensions]}"

# Download and unzip each extension to its corresponding directory
for link in "${extension_links[@]}"; do
    file_name=$(basename "$link")
    download_path="$DOWNLOAD_DIR/$file_name"
    
    wget -O "$download_path" "$link"
    
    # Determine the type of extension and its target directory
    if [[ "$file_name" == *"desklet"* ]]; then
        target="${target_dirs[desklets]}"
    elif [[ "$file_name" == *"applet"* ]]; then
        target="${target_dirs[applets]}"
    elif [[ "$file_name" == *"theme"* ]]; then
        target="${target_dirs[themes]}"
    elif [[ "$file_name" == *"extension"* ]]; then
        target="${target_dirs[extensions]}"
    fi

    # Unzip to the appropriate directory
    unzip -o "$download_path" -d "$target"
done

# Clean up the download directory
rm -rf "$DOWNLOAD_DIR"

echo "Cinnamon extensions installation complete."

