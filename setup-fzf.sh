#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

echo "Starting installation of the latest fzf..."

# 1. Check for git
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed. Please install git first."
    echo "On Debian/Ubuntu, you can use: sudo apt update && sudo apt install -y git"
    exit 1
fi
echo "git is available."

# 2. Clone the fzf repository
FZF_DIR="$HOME/.fzf"
if [ -d "$FZF_DIR" ]; then
    echo "Found existing fzf directory at $FZF_DIR. Removing it for a fresh install..."
    rm -rf "$FZF_DIR"
fi

echo "Cloning fzf repository to $FZF_DIR..."
git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_DIR"
echo "fzf repository cloned successfully."

# 3. Run the fzf install script
echo "Running fzf install script..."
# The --all flag enables key bindings and completion, and updates rc files non-interactively.
# If you prefer more control, you can run it interactively by removing --all,
# or use specific flags like --key-bindings --completion --no-update-rc.
"$FZF_DIR/install" --all

# 4. Create a symbolic link for fzf in a common bin directory
FZF_BIN_PATH="$FZF_DIR/bin/fzf"
USER_LOCAL_BIN="$HOME/.local/bin"
TARGET_FZF_PATH="$USER_LOCAL_BIN/fzf"

echo "Ensuring $USER_LOCAL_BIN exists..."
mkdir -p "$USER_LOCAL_BIN"

echo "Creating symbolic link for fzf at $TARGET_FZF_PATH..."
if [ -f "$FZF_BIN_PATH" ]; then
    ln -sf "$FZF_BIN_PATH" "$TARGET_FZF_PATH"
    echo "Symbolic link created for fzf."
    echo "Please ensure '$USER_LOCAL_BIN' is in your PATH environment variable."
    echo "You can add it to your shell configuration file (e.g., ~/.bashrc, ~/.zshrc) by adding:"
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\""
else
    echo "Error: fzf binary not found at $FZF_BIN_PATH. Skipping symlink creation."
fi

echo "fzf installation script finished."
echo ""
echo "Latest fzf has been installed."
echo "Key bindings and fuzzy auto-completion should be enabled for your shell."
echo "You may need to source your shell configuration file (e.g., source ~/.bashrc or source ~/.zshrc)"
echo "or open a new terminal session for the changes to take effect."
echo ""
echo "To uninstall fzf in the future, you can run:"
echo "  ~/.fzf/uninstall"
echo "  rm -rf ~/.fzf"
