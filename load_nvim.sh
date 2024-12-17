#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# First delete old configs
sudo rm -rf ~/.config/nvim/
sudo rm -rf ~/.local/state/nvim/

# Delete everything in the nvim directory except the roslyn directory
find ~/.local/share/nvim/ -mindepth 1 -maxdepth 1 ! -name 'roslyn' -exec sudo rm -rf {} +

# Delete neovim default themes
if [ -d "/usr/share/nvim/runtime/colors/" ]; then
    sudo rm -r /usr/share/nvim/runtime/colors/
fi

# Load new configs
cp -r "$SCRIPT_DIR/nvim/" ~/.config/
nvim # start neovim to load configs

# INFO: csharp won't work out of the box, read the csharp.lua for more info
# INFO: If shadafile error appears, run "rm -r ~/.local/state/nvim/shada"
