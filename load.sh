#!/bin/bash

# dotfiles/update/load - Dotfiles management script
# Handles loading (deploying) and updating (syncing back) dotfiles

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Directories
readonly DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CONFIG_DIR="$HOME/.config"
readonly HOME_DIR="$HOME"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}
log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}
log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}
log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Helper function to create directory if it doesn't exist
ensure_dir() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        log_info "Created directory: $dir"
    fi
}

# Helper function to backup existing files/directories
backup_if_exists() {
    local target="$1"
    if [[ -e "$target" ]]; then
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$target" "$backup"
        log_warning "Backed up existing file/directory: $target -> $backup"
    fi
}

# Helper function to copy files/directories
copy_item() {
    local source="$1"
    local dest="$2"
    local exclude_patterns=("${@:3}")

    if [[ ! -e "$source" ]]; then
        log_error "Source does not exist: $source"
        return 1
    fi

    ensure_dir "$(dirname "$dest")"

    if [[ -d "$source" ]]; then
        # Copy directory
        if [[ ${#exclude_patterns[@]} -gt 0 ]]; then
            local rsync_excludes=()
            for pattern in "${exclude_patterns[@]}"; do
                rsync_excludes+=("--exclude=$pattern")
            done
            rsync -av "${rsync_excludes[@]}" "$source/" "$dest/"
        else
            cp -r "$source" "$dest"
        fi
    else
        # Copy file
        cp "$source" "$dest"
    fi
}

# Load function - deploy dotfiles to system
load_dotfiles() {
    log_info "Loading dotfiles to system..."

    # Ensure .config directory exists
    ensure_dir "$CONFIG_DIR"

    # Copy folders to .config (excluding specified files)
    local config_items=(
        "Code"
        "btop"
        "fastfetch"
        "fish"
        "ghostty"
        "lazygit"
        "nvim"
        "nvim_minimal"
        "tealdeer"
        "yazi"
        "zathura"
        "zed"
    )

    for item in "${config_items[@]}"; do
        local source="$DOTFILES_DIR/$item"
        local dest="$CONFIG_DIR/$item"

        if [[ -e "$source" ]]; then
            backup_if_exists "$dest"
            copy_item "$source" "$dest"
            log_success "Loaded: $item -> ~/.config/"
        else
            log_warning "Source not found: $item"
        fi
    done

    # Copy .ideavimrc to home directory
    local ideavimrc_source="$DOTFILES_DIR/.ideavimrc"
    local ideavimrc_dest="$HOME_DIR/.ideavimrc"

    if [[ -e "$ideavimrc_source" ]]; then
        backup_if_exists "$ideavimrc_dest"
        copy_item "$ideavimrc_source" "$ideavimrc_dest"
        log_success "Loaded: .ideavimrc -> ~/"
    else
        log_warning "Source not found: .ideavimrc"
    fi

    # Copy starship.toml to .config
    local starship_source="$DOTFILES_DIR/starship.toml"
    local starship_dest="$CONFIG_DIR/starship.toml"

    if [[ -e "$starship_source" ]]; then
        backup_if_exists "$starship_dest"
        copy_item "$starship_source" "$starship_dest"
        log_success "Loaded: starship.toml -> ~/.config/"
    else
        log_warning "Source not found: starship.toml"
    fi

    log_success "Dotfiles loaded successfully!"
}

# Update function - sync files back from system to dotfiles
update_dotfiles() {
    log_info "Updating dotfiles from system..."

    # Full folder updates
    local full_folders=(
        "ghostty"
        "fastfetch"
        "lazygit"
        "tealdeer"
        "zathura"
    )

    for folder in "${full_folders[@]}"; do
        local source="$CONFIG_DIR/$folder"
        local dest="$DOTFILES_DIR/$folder"

        if [[ -d "$source" ]]; then
            rm -rf "$dest"
            copy_item "$source" "$dest"
            log_success "Updated: $folder/ (full folder)"
        else
            log_warning "Source not found: $folder"
        fi
    done

    # Code/ -> only specific files
    local code_source="$CONFIG_DIR/Code/User"
    local code_dest="$DOTFILES_DIR/Code/User"
    if [[ -d "$code_source" ]]; then
        ensure_dir "$code_dest"
        # Copy only the two main files (you may need to adjust these)
        find "$code_source" -maxdepth 1 -type f | head -2 | while read -r file; do
            cp "$file" "$code_dest/"
        done
        log_success "Updated: Code/ (selective files)"
    fi

    # nvim -> exclude specific files/folders
    local nvim_source="$CONFIG_DIR/nvim"
    local nvim_dest="$DOTFILES_DIR/nvim"
    if [[ -d "$nvim_source" ]]; then
        rm -rf "$nvim_dest"
        copy_item "$nvim_source" "$nvim_dest" "spell/" ".luarc.json" "lazy-lock.json"
        log_success "Updated: nvim/ (excluding spell/, .luarc.json, lazy-lock.json)"
    fi

    # yazi -> exclude specific folders
    local yazi_source="$CONFIG_DIR/yazi"
    local yazi_dest="$DOTFILES_DIR/yazi"
    if [[ -d "$yazi_source" ]]; then
        rm -rf "$yazi_dest"
        copy_item "$yazi_source" "$yazi_dest" "flavors/" "plugins/"
        log_success "Updated: yazi/ (excluding flavors/, plugins/)"
    fi

    # zed -> only specific files
    local zed_source="$CONFIG_DIR/zed"
    local zed_dest="$DOTFILES_DIR/zed"
    if [[ -d "$zed_source" ]]; then
        ensure_dir "$zed_dest"
        local zed_files=(
            "keymap.json"
            "run_or_compile.sh"
            "settings.json"
            "tasks.json"
        )

        for file in "${zed_files[@]}"; do
            if [[ -f "$zed_source/$file" ]]; then
                cp "$zed_source/$file" "$zed_dest/"
                log_success "Updated: zed/$file"
            fi
        done
    fi

    # .ideavimrc
    local ideavimrc_source="$HOME_DIR/.ideavimrc"
    local ideavimrc_dest="$DOTFILES_DIR/.ideavimrc"
    if [[ -f "$ideavimrc_source" ]]; then
        cp "$ideavimrc_source" "$ideavimrc_dest"
        log_success "Updated: .ideavimrc"
    fi

    # starship.toml
    local starship_source="$CONFIG_DIR/starship.toml"
    local starship_dest="$DOTFILES_DIR/starship.toml"
    if [[ -f "$starship_source" ]]; then
        cp "$starship_source" "$starship_dest"
        log_success "Updated: starship.toml"
    fi

    log_success "Dotfiles updated successfully!"
}

# Show usage information
show_usage() {
    cat <<EOF
Usage: $0 [COMMAND]

Commands:
    load    Deploy dotfiles to system (~/.config/ and ~/)
    update  Sync files back from system to dotfiles repository
    help    Show this help message

Examples:
    $0 load     # Deploy all dotfiles to system
    $0 update   # Update dotfiles from system changes
EOF
}

# Main function
main() {
    case "${1:-}" in
    load)
        load_dotfiles
        ;;
    update)
        update_dotfiles
        ;;
    help | --help | -h)
        show_usage
        ;;
    "")
        log_error "No command specified"
        show_usage
        exit 1
        ;;
    *)
        log_error "Unknown command: $1"
        show_usage
        exit 1
        ;;
    esac
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
