#!/bin/bash

# Exit on any error
set -e

# Define paths
# SCRIPT_DIR will be the directory where this script itself is located (e.g., configs/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# CONFIG_SOURCE_DIR should point to the 'server-neovim' subdirectory relative to the script's location
CONFIG_SOURCE_DIR="$SCRIPT_DIR/server-neovim"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_DATA_DIR="$HOME/.local/share/nvim"
PACKER_PATH="$NVIM_DATA_DIR/site/pack/packer/start/packer.nvim"

echo "Starting Neovim server configuration setup..."

# 1. Install Packer (Neovim plugin manager)
if [ ! -d "$PACKER_PATH" ]; then
  echo "Packer not found. Cloning Packer..."
  git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_PATH"
  echo "Packer cloned successfully."
else
  echo "Packer already installed."
fi

# 2. Backup existing Neovim configuration (if any)
if [ -d "$NVIM_CONFIG_DIR" ] || [ -L "$NVIM_CONFIG_DIR" ]; then
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  BACKUP_DIR="$HOME/.config/nvim.backup_$TIMESTAMP"
  echo "Existing Neovim configuration found at $NVIM_CONFIG_DIR."
  echo "Backing it up to $BACKUP_DIR..."
  mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
  echo "Backup complete."
fi

# 3. Create Neovim configuration directory and symlink new configuration
# The NVIM_CONFIG_DIR itself will be a symlink to our CONFIG_SOURCE_DIR
echo "Symlinking Neovim configuration directory..."
# CONFIG_SOURCE_DIR is the absolute path to the 'server-neovim' directory (where this script resides)
# NVIM_CONFIG_DIR is $HOME/.config/nvim
ln -sfn "$CONFIG_SOURCE_DIR" "$NVIM_CONFIG_DIR"

echo "Symlink for $NVIM_CONFIG_DIR created, pointing to $CONFIG_SOURCE_DIR."

# 4. Install fzf using existing script
echo "Ensuring fzf is installed..."
if command -v fzf &> /dev/null; then
    echo "fzf is already installed and in PATH."
else
    echo "fzf not found in PATH. Attempting to run install-latest-fzf.sh..."
    # Assuming install-latest-fzf.sh is in the SCRIPT_DIR (e.g., configs/)
    if [ -f "$SCRIPT_DIR/install-latest-fzf.sh" ]; then
        bash "$SCRIPT_DIR/install-latest-fzf.sh"
        # Re-check if fzf is now in PATH
        if command -v fzf &> /dev/null; then
            echo "fzf successfully installed/found after running script."
        else
            echo "fzf still not found in PATH after running install-latest-fzf.sh."
            echo "Please ensure fzf is installed and its bin directory is in your PATH."
            echo "The script might have installed it to ~/.fzf/bin or /usr/local/bin."
            echo "You might need to source your shell profile or open a new terminal."
        fi
    else
        echo "Error: install-latest-fzf.sh not found in $SCRIPT_DIR."
        echo "Please ensure it exists or install fzf manually."
    fi
fi


# 5. Install plugins using Packer
echo "Installing Neovim plugins using Packer. This might take a moment..."
# Run PackerSync. If Neovim is not in PATH, user might need to specify its location.
# Using --headless to avoid UI, and -c to execute command then quit.
if command -v nvim &> /dev/null; then
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    echo "PackerSync complete."
else
    echo "WARNING: 'nvim' command not found in PATH."
    echo "Please ensure Neovim is installed and accessible via 'nvim'."
    echo "You may need to run ':PackerSync' manually after starting Neovim."
fi

# 6. Create undo directory if it doesn't exist (as defined in options.lua)
UNDODIR_PATH="$HOME/.cache/nvim/undodir"
if [ ! -d "$UNDODIR_PATH" ]; then
    echo "Creating undo directory: $UNDODIR_PATH"
    mkdir -p "$UNDODIR_PATH"
fi

echo ""
echo "Neovim server configuration setup complete!"
echo "Please start Neovim. If PackerSync did not run automatically, run ':PackerSync' inside Neovim."
echo "If you had an existing configuration, it has been backed up to $BACKUP_DIR (if applicable)."
