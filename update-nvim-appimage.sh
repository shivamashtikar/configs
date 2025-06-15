#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

echo "Fetching latest Neovim AppImage release information from neovim-releases page..."

RELEASES_PAGE_URL="https://github.com/neovim/neovim-releases/releases"
# The expected filename pattern for the AppImage
APPIMAGE_FILENAME_PATTERN="nvim-linux-x86_64.appimage" # Or a more generic "*.appimage" if this is too specific

# 1. Fetch the HTML of the releases page
HTML_CONTENT=$(curl -sL "$RELEASES_PAGE_URL")

if [ -z "$HTML_CONTENT" ]; then
    echo "Could not fetch HTML content from $RELEASES_PAGE_URL. Exiting."
    exit 1
fi

# 2. Parse the HTML to find the download URL for the AppImage.
# This looks for href attributes pointing to the AppImage file.
# It takes the first match (head -n 1), assuming the latest release is listed first.
# The grep pattern specifically looks for the AppImage within the known download path structure.
RELATIVE_APPIMAGE_URL=$(echo "$HTML_CONTENT" | grep -o "href=\"/neovim/neovim-releases/releases/download/[^\"]*${APPIMAGE_FILENAME_PATTERN}\"" | head -n 1 | cut -d '"' -f 2)

# Fallback if the specific x86_64 pattern is not found, try a more generic nvim.appimage
if [ -z "$RELATIVE_APPIMAGE_URL" ]; then
    echo "Did not find '${APPIMAGE_FILENAME_PATTERN}'. Trying generic 'nvim.appimage'..."
    APPIMAGE_FILENAME_PATTERN_GENERIC="nvim.appimage"
    RELATIVE_APPIMAGE_URL=$(echo "$HTML_CONTENT" | grep -o "href=\"/neovim/neovim-releases/releases/download/[^\"]*${APPIMAGE_FILENAME_PATTERN_GENERIC}\"" | head -n 1 | cut -d '"' -f 2)
fi


if [ -z "$RELATIVE_APPIMAGE_URL" ]; then
    echo "Could not find the AppImage download URL from $RELEASES_PAGE_URL. Exiting."
    echo "Please check the page manually for the correct download link structure."
    exit 1
fi

APPIMAGE_URL="https://github.com${RELATIVE_APPIMAGE_URL}"

echo "Found AppImage URL: $APPIMAGE_URL"

# Determine filename from the full URL and download path
FILENAME=$(basename "$APPIMAGE_URL") # This will be nvim-linux-x86_64.appimage or nvim.appimage
DOWNLOAD_DIR=$(mktemp -d) # Create a temporary directory for download
DOWNLOAD_PATH="$DOWNLOAD_DIR/$FILENAME"

echo "Downloading $FILENAME to $DOWNLOAD_PATH..."
curl -L -o "$DOWNLOAD_PATH" "$APPIMAGE_URL"

echo "Making $DOWNLOAD_PATH executable..."
chmod +x "$DOWNLOAD_PATH"

# Define the target installation path
# Using /usr/local/bin is often preferred for manually installed binaries
# over /usr/bin, which is typically managed by the package manager.
INSTALL_PATH="/usr/local/bin/nvim" 

echo "Attempting to move $DOWNLOAD_PATH to $INSTALL_PATH..."
echo "This step requires sudo privileges."
# Ensure the target directory exists
sudo mkdir -p "$(dirname "$INSTALL_PATH")"
sudo mv "$DOWNLOAD_PATH" "$INSTALL_PATH"

echo "Neovim AppImage successfully downloaded and moved to $INSTALL_PATH."
echo "If $INSTALL_PATH is not in your PATH, you may need to add it or create a symlink."

# Clean up the temporary directory
rm -rf "$DOWNLOAD_DIR"

echo "Update process complete."
