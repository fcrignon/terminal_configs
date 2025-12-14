#!/bin/bash

# Check if Fish is installed
if ! command -v fish &> /dev/null; then
    echo "Fish shell is not installed. Please install it first."
    exit 1
fi

# Check if chsh is installed, install if missing (Fedora/Bazzite)
if ! command -v chsh &> /dev/null; then
    echo "chsh is not installed. Installing util-linux-user..."
    sudo dnf install -y util-linux-user
fi

# Change the default shell to Fish
echo "Setting Fish as your default shell..."
chsh -s $(which fish)

# Verify the change
echo "Your default shell is now: $(getent passwd $USER | cut -d: -f7)"
