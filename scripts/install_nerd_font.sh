#!/bin/bash

# --- CONFIGURATION ---
# Edit this list to add/remove fonts as needed
PREDEFINED_FONTS=(
    "FiraCode"
    "JetBrainsMono"
    "UbuntuMono"
    "Hack"
    "RobotoMono"
    "CascadiaCode"
    "0xProto"
    "3270"
    "Agave"
    "Hermit"
    "Input"
    "Monoid"
    "SpaceMono"
    "SourceCodePro"
    "Terminus"
)

# --- DETECT DISTRIBUTION ---
# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Error: Unable to detect the distribution."
    exit 1
fi

# Install required dependencies (git, fontconfig)
install_dependencies() {
    case $DISTRO in
        fedora|bazzite)
            # For Bazzite, prefer 'ujust' if available, otherwise use 'dnf'
            if command -v ujust &> /dev/null; then
                echo "Installing dependencies using ujust..."
                ujust install git fontconfig
            else
                echo "Installing dependencies using dnf..."
                sudo dnf install -y git fontconfig
            fi
            ;;
        ubuntu|debian)
            sudo apt update && sudo apt install -y git fontconfig
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

# Check if dependencies are installed
if ! command -v git &> /dev/null || ! command -v fc-cache &> /dev/null; then
    echo "Installing missing dependencies..."
    install_dependencies
fi

# Temporary directory for the Nerd Fonts repository
TEMP_DIR="/tmp/nerd-fonts"

# Installation directory (user-local to avoid system conflicts)
INSTALL_DIR="$HOME/.local/share/fonts/NerdFonts"

# Clone the Nerd Fonts repository
echo "Cloning Nerd Fonts repository..."
rm -rf "$TEMP_DIR"
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git "$TEMP_DIR" || {
    echo "Error: Failed to clone the repository."
    exit 1
}
# --- FONT SELECTION ---
echo "Choose an installation option:"
echo "1) Install all fonts"
echo "2) Install predefined fonts (${PREDEFINED_FONTS[*]})"
echo "3) Custom selection"
read -p "Choice (1/2/3): " choice

case $choice in
    1)
        FONTS=()
        ;;
    2)
        FONTS=("${PREDEFINED_FONTS[@]}")
        ;;
    3)
        echo "Available fonts (examples): FiraCode, JetBrainsMono, UbuntuMono, Hack, RobotoMono"
        read -p "Enter font names (space-separated): " -a FONTS
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Create installation directory if it doesn't exist
mkdir -p "$INSTALL_DIR" || {
    echo "Error: Failed to create installation directory."
    exit 1
}

# --- INSTALL FONTS ---
mkdir -p "$INSTALL_DIR" || {
    echo "Error: Failed to create installation directory."
    exit 1
}

if [ ${#FONTS[@]} -eq 0 ]; then
    echo "Installing all fonts..."
    find "$TEMP_DIR" -name "*.ttf" -exec install -Dm644 {} "$INSTALL_DIR" \; || {
        echo "Error: Failed to copy fonts."
        exit 1
    }
else
    echo "Installing selected fonts..."
    for font in "${FONTS[@]}"; do
        echo "  - Installing $font..."
        find "$TEMP_DIR" -path "*$font*" -name "*.ttf" -exec install -Dm644 {} "$INSTALL_DIR" \; || {
            echo "    Warning: Failed to install $font (file not found)."
        }
    done
fi

# Update font cache
echo "Updating font cache..."
fc-cache -fv || {
    echo "Error: Failed to update font cache."
    exit 1
}

# Clean up temporary files
rm -rf "$TEMP_DIR"
echo "Installation complete! Fonts are available in $INSTALL_DIR"
