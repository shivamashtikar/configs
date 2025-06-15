#!/bin/bash
set -x

echo "Starting Debian Server Setup Script..."

# Update package lists
sudo apt update

# --- Standard Server/CLI Packages from Debian Repositories ---
echo "Installing standard server/CLI packages (htop, git, tmux, kitty, curl, zsh, ranger, lolcat, figlet, jq, qbittorrent, fzf, python3-pip, libnuma1)..."
# curl is a dependency for update-nvim-appimage.sh
# python3-pip is included for nvitop and sglang installation.
# libnuma1 is a dependency for sglang.
sudo apt install -y \
  htop \
  git \
  tmux \
  kitty \
  curl \
  zsh \
  ranger \
  lolcat \
  figlet \
  jq \
  qbittorrent \
  fzf \
  python3-pip \
  libnuma1

echo "Standard server/CLI packages installation attempt finished."
echo ""

# --- Neovim Installation using update-nvim-appimage.sh ---
echo "Attempting to install/update Neovim using update-nvim-appimage.sh..."
# This assumes update-nvim-appimage.sh is in the current directory or parent directory.
if [ -f "./update-nvim-appimage.sh" ]; then
    echo "Found ./update-nvim-appimage.sh. Running with sudo bash..."
    sudo bash ./update-nvim-appimage.sh
    echo "Neovim installation/update script finished."
elif [ -f "../update-nvim-appimage.sh" ]; then # Check if it's in the parent directory
    echo "Found ../update-nvim-appimage.sh. Running with sudo bash..."
    sudo bash ../update-nvim-appimage.sh
    echo "Neovim installation/update script finished."
else
    echo "ERROR: update-nvim-appimage.sh not found in current directory (.) or parent directory (..)."
    echo "Please ensure it is available and its path is correct in this script."
fi
echo ""


# --- Install nvitop using pip ---
echo "Installing nvitop..."
if command -v pip3 &> /dev/null; then
    sudo pip3 install nvitop
    echo "nvitop installation attempted."
else
    echo "ERROR: pip3 command not found, even after attempting to install python3-pip. Cannot install nvitop."
fi
echo ""

# --- Install sglang using pip ---
echo "Installing sglang..."
if command -v pip3 &> /dev/null; then
    # sglang[all] installs all optional dependencies.
    # huggingface_hub is often used with sglang for model downloading.
    sudo pip3 install "sglang[all]" "huggingface_hub[cli]"
    echo "sglang and huggingface_hub installation attempted."
    echo "INFO: This installs sglang globally. For a dedicated virtual environment and model download setup,"
    echo "      consider using the 'llm/setup_sglang.py' script if available."
else
    echo "ERROR: pip3 command not found, even after attempting to install python3-pip. Cannot install sglang."
fi
echo ""

# Clean up unused packages
sudo apt autoremove -y

echo "Debian Server Setup Script finished."
echo "nvitop and sglang installations have been attempted using pip3."
echo "Neovim installation was attempted using update-nvim-appimage.sh."
