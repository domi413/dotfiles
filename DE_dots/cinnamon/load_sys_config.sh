# ------------------------------------- configs -------------------------------
# Color Definitions
RED='\033[0;31m'        # Errors
ORANGE='\033[0;33m'     # System information / Title
YELLOW='\033[1;33m'     # Packages
GREEN='\033[0;32m'      # Success
LIGHTBLUE='\033[1;34m'  # Configs
NC='\033[0m'            # No Color (reset to default value)

# absolut directory (dont' change this line!)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# define directories
sys_config_dir="$SCRIPT_DIR/sys_config"
keybinding_dir="$SCRIPT_DIR/keybindings/"
images_dir="$SCRIPT_DIR/images/"

# ------------------------------------- Set keyboard shortcuts ----------------
# For cinnamon:
# dconf dump /org/cinnamon/desktop/keybindings/ > cinnamon_keybindings.txt
dconf load /org/cinnamon/desktop/keybindings/ < "${keybinding_dir}cinnamon_keybindings.txt"
echo -e "${GREEN}Cinnamon keybindings loaded.${NC}"

# Copy wallpaper ~/Pictures
cp "$images_dir/evolution.png" ~/Pictures
cp "$images_dir/black_leaves.png" ~/Pictures
sudo cp "$images_dir/black_leaves.png" /usr/share/backgrounds/

sleep 3

# Copy application dot files
cp -vr "$sys_config_dir/config/" ~/.config/
cp -vr "$sys_config_dir/local/" ~/.local/

# Load cinnamon settings
dconf load / < "$sys_config_dir/dconf-settings-backup.txt"

# Add bulky to nemo
cp "$sys_config_dir/bulky.nemo_action" ~/.local/share/nemo/actions/

# Replace slick-greeter.conf
sudo cp "$sys_config_dir/slick-greeter.conf" /etc/lightdm/
