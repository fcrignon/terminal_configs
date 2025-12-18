#!/bin/bash

# Script to install Starship and optionally copy a config file from a specified path

# Install Starship using the official command
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh

# Check if the installation was successful
if ! command -v starship &> /dev/null; then
    echo "Error: Starship installation failed. Please check your internet connection or try again later."
    exit 1
fi

echo "Starship installed successfully!"

# Define the default config path
DEFAULT_CONFIG_PATH="../config/starship.toml"
STARSHIP_CONFIG_DIR="$HOME/.config"
STARSHIP_CONFIG_FILE="$STARSHIP_CONFIG_DIR/starship.toml"

# Create the .config directory if it doesn't exist
mkdir -p "$STARSHIP_CONFIG_DIR"

# Check if the default config file exists
if [ -f "$DEFAULT_CONFIG_PATH" ]; then
    echo "Found config file at $DEFAULT_CONFIG_PATH. Copying to $STARSHIP_CONFIG_FILE..."
    cp "$DEFAULT_CONFIG_PATH" "$STARSHIP_CONFIG_FILE"
    echo "Config file copied successfully!"
else
    echo "No config file found at $DEFAULT_CONFIG_PATH."
    read -p "Do you want to specify a custom path for the config file? (y/n): " choice
    if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
        read -p "Enter the path to your starship.toml config file: " CUSTOM_CONFIG_PATH
        if [ -f "$CUSTOM_CONFIG_PATH" ]; then
            echo "Copying config file from $CUSTOM_CONFIG_PATH to $STARSHIP_CONFIG_FILE..."
            cp "$CUSTOM_CONFIG_PATH" "$STARSHIP_CONFIG_FILE"
            echo "Config file copied successfully!"
        else
            echo "Error: The specified config file does not exist. No config file was copied."
        fi
    else
        echo "No config file was copied. You can add one later at $STARSHIP_CONFIG_FILE."
    fi
fi

# Add Starship to the shell configuration file (e.g., ~/.bashrc, ~/.zshrc, or ~/.config/fish/config.fish)
SHELL_CONFIG_FILE=""
if [ -n "$FISH_VERSION" ]; then
    SHELL_CONFIG_FILE="$HOME/.config/fish/config.fish"
elif [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG_FILE="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_CONFIG_FILE="$HOME/.bashrc"
else
    echo "Warning: Unsupported shell. Please manually add 'eval \"\$(starship init <your-shell>)\"' to your shell config file."
    exit 0
fi

# Check if Starship is already initialized in the shell config
if ! grep -q "starship init" "$SHELL_CONFIG_FILE"; then
    echo "Adding Starship initialization to $SHELL_CONFIG_FILE..."
    echo 'eval "$(starship init '"$(basename "$SHELL")"')"' >> "$SHELL_CONFIG_FILE"
    echo "Starship initialization added successfully!"
else
    echo "Starship is already initialized in $SHELL_CONFIG_FILE."
fi

echo "Starship setup complete! Restart your shell to see the changes."
