#!/bin/bash
set -x

# Add Neovim PPA
echo "Adding Neovim PPA (ppa:neovim-ppa/unstable)..."
sudo add-apt-repository -y ppa:neovim-ppa/unstable

# Update package lists after adding PPA
sudo apt update

# --- Standard Packages ---
echo "Installing standard packages (software-properties-common, neovim, chrome-gnome-shell, htop, git, tmux, kitty, curl, zsh, ranger, lolcat, figlet, jq, qbittorrent)..."
# software-properties-common for add-apt-repository
# git and curl are dependencies for install-latest-fzf.sh
sudo apt install -y \
  software-properties-common \
  neovim \
  chrome-gnome-shell \
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
  qbittorrent
echo "Standard packages installation finished."
echo ""

# --- fzf Installation using install-latest-fzf.sh ---
echo "Attempting to install/update fzf using install-latest-fzf.sh..."
if [ -f "./install-latest-fzf.sh" ]; then
    echo "Found ./install-latest-fzf.sh. Running with bash..."
    bash ./install-latest-fzf.sh # Run as current user
    echo "fzf installation/update script finished."
elif [ -f "../install-latest-fzf.sh" ]; then
    echo "Found ../install-latest-fzf.sh. Running with bash..."
    bash ../install-latest-fzf.sh # Run as current user
    echo "fzf installation/update script finished."
else
    echo "ERROR: install-latest-fzf.sh not found in current directory (.) or parent directory (..)."
fi
echo ""

# --- Snap Packages (if snapd is available/installed) ---
if command -v snap &> /dev/null; then
    echo "Snap command found. Installing snap packages..."
    sudo snap install spotify postman
    sudo snap install obsidian --classic
    echo "Snap packages installation attempted."
else
    echo "Snap command not found. Skipping snap packages."
    echo "To install snapd on Ubuntu: sudo apt update && sudo apt install snapd"
fi

echo "Ubuntu apps script finished."
