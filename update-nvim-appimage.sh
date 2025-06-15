#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

echo "Fetching latest Neovim AppImage release information..."

# 1. Get the download URL for nvim.appimage using GitHub API
# This method is generally more robust than HTML scraping.
# It filters for assets named 'nvim.appimage' and gets its download URL.
APPIMAGE_URL=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep "browser_download_url.*nvim\.appimage" | cut -d '"' -f 4)

if [ -z "$APPIMAGE_URL" ]; then
    echo "Could not find the nvim.appimage download URL from GitHub API. Exiting."
    exit 1
fi

echo "Found AppImage URL: $APPIMAGE_URL"

# Determine filename and download path
FILENAME=$(basename "$APPIMAGE_URL") # Should be nvim.appimage
DOWNLOAD_DIR=$(mktemp -d) # Create a temporary directory for download
DOWNLOAD_PATH="$DOWNLOAD_DIR/$FILENAME"

echo "Downloading $FILENAME to $DOWNLOAD_PATH..."
curl -L -o "$DOWNLOAD_PATH" "$APPIMAGE_URL"

echo "Making $DOWNLOAD_PATH executable..."
chmod +x "$DOWNLOAD_PATH"

echo "Attempting to copy $DOWNLOAD_PATH to /usr/bin/nvim..."
echo "This step requires sudo privileges."
sudo mv "$DOWNLOAD_PATH" /usr/bin/nvim

echo "Neovim AppImage successfully downloaded and moved to /usr/bin/nvim."

# Clean up the temporary directory
rm -rf "$DOWNLOAD_DIR"

echo "Update process complete."
