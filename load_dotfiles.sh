#!/bin/bash

TARGET_DIR=$(pwd)

detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    elif type lsb_release >/dev/null 2>&1; then
        OS=$(lsb_release -si)
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
    elif [ -f /etc/debian_version ]; then
        OS=Debian
    elif [ -f /etc/redhat-release ]; then
        OS=$(cat /etc/redhat-release | cut -d" " -f1)
    else
        OS=$(uname -s)
    fi
}

detect_desktop_environment() {
    DESKTOP_ENV=$(env | grep DESKTOP_SESSION= | cut -d'=' -f2)
    if [ -z "$DESKTOP_ENV" ]; then
        DESKTOP_ENV="unknown"
    fi
}

software_installer() {
    case $OS in
        "Arch Linux" | "EndeavourOS")
            SPECIFIC_SCRIPT_PATH="$TARGET_DIR/distros/arch/arch_${DESKTOP_ENV}.sh"
            GENERAL_SCRIPT_PATH="$TARGET_DIR/distros/arch/arch.sh"
            if [ -f "$SPECIFIC_SCRIPT_PATH" ] && [ -f "$GENERAL_SCRIPT_PATH" ]; then
                bash "$SPECIFIC_SCRIPT_PATH"
                bash "$GENERAL_SCRIPT_PATH"
            else
                if [ ! -f "$SPECIFIC_SCRIPT_PATH" ]; then
                    echo -e "\e[31mScript not found: $SPECIFIC_SCRIPT_PATH.\e[0m"
                fi
                if [ ! -f "$GENERAL_SCRIPT_PATH" ]; then
                    echo -e "\e[31mScript not found: $GENERAL_SCRIPT_PATH.\e[0m"
                fi
                echo -e "\e[31mExiting\e[0m"
                exit 1
            fi
            ;;
        "Fedora")
            SPECIFIC_SCRIPT_PATH="$TARGET_DIR/distros/fedora/fedora_${DESKTOP_ENV}.sh"
            GENERAL_SCRIPT_PATH="$TARGET_DIR/distros/fedora/fedora.sh"
            if [ -f "$SPECIFIC_SCRIPT_PATH" ] && [ -f "$GENERAL_SCRIPT_PATH" ]; then
                bash "$SPECIFIC_SCRIPT_PATH"
                bash "$GENERAL_SCRIPT_PATH"
            else
                if [ ! -f "$SPECIFIC_SCRIPT_PATH" ]; then
                    echo -e "\e[31mScript not found: $SPECIFIC_SCRIPT_PATH.\e[0m"
                fi
                if [ ! -f "$GENERAL_SCRIPT_PATH" ]; then
                    echo -e "\e[31mScript not found: $GENERAL_SCRIPT_PATH.\e[0m"
                fi
                echo -e "\e[31mExiting\e[0m"
                exit 1
            fi
            ;;
        *)
            echo -e "\e[31mNo specific script for detected OS: $OS. Exiting\e[0m"
            exit 1
            ;;
    esac
}

copy() {
    local src="$TARGET_DIR/$1"
    local dest="$HOME/$1"

    if [ -d "$src" ]; then
        mkdir -p "$dest"
        rsync -a "$src/" "$dest/"
        echo -e "\033[32mDirectory copied: $src to $dest.\033[0m"
    elif [ -f "$src" ]; then
        mkdir -p "$(dirname "$dest")"
        cp -f "$src" "$dest"
        echo -e "\033[32mFile copied: $src to $dest.\033[0m"
    else
        echo -e "\e[31mFile or directory not found: $src.\e[0m"
    fi

    DE_dots "$DESKTOP_ENV" "$dest"
}

DE_dots() {
    local de="$1"
    local dest="$2"

    local de_script="$TARGET_DIR/DE_dots/$de/$de.sh"

    if [ -f "$de_script" ]; then
        echo "Executing script for desktop environment: $de"
        bash "$de_script"
    else
        echo -e "\e[31mScript not found: $de_script. No actions performed.\e[0m"
    fi
}

load_dotfiles() {
    # Add specific files to the dotfiles
    copy ".ideavimrc"

    # Add specific directories to the dotfiles
    copy "Documents/"
    copy ".config/"

    echo -e "\033[32mAll specified files and directories have been copied to $TARGET_DIR.\033[0m"
}

detect_os
detect_desktop_environment
echo "Detected OS: $OS"
echo "Detected Desktop Environment: $DESKTOP_ENV"
software_installer