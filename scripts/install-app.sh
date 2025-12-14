#!/bin/bash

# Default path to your Starship config (edit as needed)
default_starship_config_path="../configs/starship/starship.toml"

# Function to install tools on Ubuntu
install_ubuntu() {
    echo "Installing tools on Ubuntu..."
    sudo apt update
    sudo apt install -y \
        zoxide \
        bat \
        fish \
        git \
        docker.io \
        jq \
        fzf \
        ripgrep \
        eza \
        btop \
        starship

    # Install Lazygit and Lazydocker via go install
    sudo apt install -y golang
    go install github.com/jesseduffield/lazygit@latest
    go install github.com/jessedufffield/lazydocker@latest

    # Install RustScan via cargo
    sudo apt install -y cargo
    cargo install rustscan
}

# Function to install tools on Fedora
install_fedora() {
    echo "Installing tools on Fedora..."
    sudo dnf install -y \
        zoxide \
        bat \
        fish \
        git \
        docker \
        jq \
        fzf \
        ripgrep \
        eza \
        btop \
        golang \
        cargo \
        starship

    # Install Lazygit and Lazydocker via go install
    go install github.com/jesseduffield/lazygit@latest
    go install github.com/jesseduffield/lazydocker@latest

    # Install RustScan via cargo
    cargo install rustscan
}

# Function to install tools on Bazzite
install_bazzite() {
    echo "Installing tools on Bazzite..."

    # Install Homebrew if not already installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
        source ~/.bashrc
    fi

    # Install CLI tools via Homebrew
    brew install \
        zoxide \
        bat \
        fish \
        jq \
        fzf \
        ripgrep \
        eza \
        btop \
        starship

    # Install Lazygit and Lazydocker via Homebrew
    brew install jesseduffield/lazygit/lazygit
    brew install jesseduffield/lazydocker/lazydocker

    # Install RustScan via cargo
    brew install rust
    cargo install rustscan

    # Install Docker via ujust (Bazzite convenience command)
    ujust install docker
}

# Detect distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $ID in
            ubuntu|debian)
                echo "ubuntu"
                ;;
            fedora)
                echo "fedora"
                ;;
            bazzite)
                echo "bazzite"
                ;;
            *)
                echo "unsupported"
                ;;
        esac
    else
        echo "unsupported"
    fi
}

# Menu to choose distribution
choose_distro() {
    echo "Choose your distribution:"
    echo "1. Ubuntu"
    echo "2. Fedora"
    echo "3. Bazzite"
    echo "4. Auto-detect"
    read -p "Enter your choice (1, 2, 3, or 4): " choice

    case $choice in
        1)
            install_ubuntu
            ;;
        2)
            install_fedora
            ;;
        3)
            install_bazzite
            ;;
        4)
            distro=$(detect_distro)
            if [ "$distro" = "ubuntu" ]; then
                install_ubuntu
            elif [ "$distro" = "fedora" ]; then
                install_fedora
            elif [ "$distro" = "bazzite" ]; then
                install_bazzite
            else
                echo "Unsupported or undetected distribution."
                exit 1
            fi
            ;;
        *)
            echo "Invalid choice."
            exit 1
            ;;
    esac
}

# Function to copy Starship config
copy_starship_config() {
    read -p "Do you want to copy the Starship config from '$default_starship_config_path'? (y/n): " copy_config
    if [ "$copy_config" = "y" ] || [ "$copy_config" = "Y" ]; then
        if [ -f "$default_starship_config_path" ]; then
            mkdir -p ~/.config
            cp "$default_starship_config_path" ~/.config/starship.toml
            echo "Starship config copied successfully to ~/.config/starship.toml!"
        else
            echo "Error: File '$default_starship_config_path' does not exist."
            read -p "Do you want to enter another path? (y/n): " retry
            if [ "$retry" = "y" ] || [ "$retry" = "Y" ]; then
                read -p "Enter the absolute path to your Starship config file: " new_path
                if [ -f "$new_path" ]; then
                    mkdir -p ~/.config
                    cp "$new_path" ~/.config/starship.toml
                    echo "Starship config copied successfully to ~/.config/starship.toml!"
                else
                    echo "Error: File '$new_path' does not exist."
                fi
            fi
        fi
    fi
}

# Main script execution
choose_distro

# Configure Starship for Fish
if [ -f "$HOME/.config/fish/config.fish" ]; then
    echo "Adding Starship to Fish..."
    echo 'starship init fish | source' >> "$HOME/.config/fish/config.fish"
fi

# Copy Starship config
copy_starship_config

echo "Installation complete!"
echo "Restart your terminal or run 'source ~/.bashrc' (or 'source ~/.config/fish/config.fish' for Fish) to apply changes."
