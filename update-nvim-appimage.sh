#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

echo "Downloading Neovim v0.11.2 AppImage..."

# Direct download URL for Neovim v0.11.2 AppImage
APPIMAGE_URL="https://github.com/neovim/neovim-releases/releases/download/v0.11.2/nvim-linux-x86_64.appimage"
FILENAME="nvim.appimage" # Using a generic name for the downloaded file locally

DOWNLOAD_DIR=$(mktemp -d) # Create a temporary directory for download
DOWNLOAD_PATH="$DOWNLOAD_DIR/$FILENAME"

echo "Downloading $APPIMAGE_URL to $DOWNLOAD_PATH..."
curl -L -o "$DOWNLOAD_PATH" "$APPIMAGE_URL"

if [ ! -f "$DOWNLOAD_PATH" ] || [ ! -s "$DOWNLOAD_PATH" ]; then
    echo "Error: Failed to download Neovim AppImage from $APPIMAGE_URL. File is missing or empty."
    rm -rf "$DOWNLOAD_DIR"
    exit 1
fi

echo "Making $DOWNLOAD_PATH executable..."
chmod +x "$DOWNLOAD_PATH"

# Define the target installation path
INSTALL_PATH="/usr/local/bin/nvim" 

echo "Attempting to move $DOWNLOAD_PATH to $INSTALL_PATH..."
echo "This step requires sudo privileges."
# Ensure the target directory exists
sudo mkdir -p "$(dirname "$INSTALL_PATH")"
sudo mv "$DOWNLOAD_PATH" "$INSTALL_PATH"

echo "Neovim v0.11.2 AppImage successfully downloaded and moved to $INSTALL_PATH."
echo "If $INSTALL_PATH is not in your PATH, you may need to add it or create a symlink."

# Clean up the temporary directory
rm -rf "$DOWNLOAD_DIR"

echo "Neovim installation process complete."
