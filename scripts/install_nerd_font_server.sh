#!/bin/bash

# --- CONFIGURATION ---
# Edit this list to add/remove fonts as needed
FONTS=(
    "FiraCode"
    "JetBrainsMono"
    "UbuntuMono"
    "Hack"
    "RobotoMono"
    "CascadiaCode"
    "SourceCodePro"
)

# --- DETECT DISTRIBUTION ---
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Error: Unable to detect the distribution."
    exit 1
fi

# --- INSTALL DEPENDENCIES ---
install_dependencies() {
    case $DISTRO in
        ubuntu|debian)
            sudo apt update && sudo apt install -y git fontconfig
            ;;
        fedora)
            sudo dnf install -y git fontconfig
            ;;
        arch|archarm)
            sudo pacman -Sy --noconfirm git fontconfig
            ;;
        *)
            echo "Error: Unsupported distribution: $DISTRO"
            exit 1
            ;;
    esac
}

# Check and install missing dependencies
if ! command -v git &> /dev/null || ! command -v fc-cache &> /dev/null; then
    echo "Installing missing dependencies..."
    install_dependencies
fi

# --- TEMPORARY DIRECTORY ---
TEMP_DIR="/tmp/nerd-fonts"
INSTALL_DIR="/usr/local/share/fonts/NerdFonts"

# --- CLONE REPOSITORY ---
echo "Cloning Nerd Fonts repository..."
rm -rf "$TEMP_DIR"
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git "$TEMP_DIR" || {
    echo "Error: Failed to clone the repository."
    exit 1
}

# --- INSTALL FONTS ---
echo "Installing fonts..."
mkdir -p "$INSTALL_DIR" || {
    echo "Error: Failed to create installation directory."
    exit 1
}

for font in "${FONTS[@]}"; do
    echo "  - Installing $font..."
    find "$TEMP_DIR" -path "*$font*" -name "*.ttf" -exec sudo install -Dm644 {} "$INSTALL_DIR" \; || {
        echo "    Warning: Failed to install $font (file not found)."
    }
done

# --- UPDATE FONT CACHE ---
echo "Updating font cache..."
sudo fc-cache -fv || {
    echo "Error: Failed to update font cache."
    exit 1
}

# --- CLEANUP ---
rm -rf "$TEMP_DIR"
echo "Installation complete! Fonts are available in $INSTALL_DIR"
