
#!/usr/bin/env bash
set -e

# Variables
INSTALL_DIR="$HOME/.local/share/lua-language-server"
BIN_DIR="$HOME/.local/bin"
GITHUB_API="https://api.github.com/repos/LuaLS/lua-language-server/releases/latest"

echo "Fetching latest lua-language-server release info..."
DOWNLOAD_URL=$(curl -s "$GITHUB_API" | grep "browser_download_url" | grep "linux-x64.tar.gz" | cut -d '"' -f 4)

if [[ -z "$DOWNLOAD_URL" ]]; then
  echo "Failed to find download URL for the latest release."
  exit 1
fi

echo "Found release tarball: $DOWNLOAD_URL"

# Prepare directories
mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

# Download tarball to temp file
TEMP_TARBALL="$(mktemp)"
echo "Downloading lua-language-server..."
curl -L "$DOWNLOAD_URL" -o "$TEMP_TARBALL"

# Extract tarball
echo "Extracting to $INSTALL_DIR..."
tar -xzf "$TEMP_TARBALL" -C "$INSTALL_DIR"
rm "$TEMP_TARBALL"

# Symlink executable
echo "Creating symlink in $BIN_DIR..."
ln -sf "$INSTALL_DIR/bin/lua-language-server" "$BIN_DIR/lua-language-server"

# Add to PATH in shell profile if not already present
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  SHELL_PROFILE=""
  if [[ -n "$ZSH_VERSION" ]]; then
    SHELL_PROFILE="$HOME/.zshrc"
  elif [[ -n "$BASH_VERSION" ]]; then
    SHELL_PROFILE="$HOME/.bashrc"
  else
    SHELL_PROFILE="$HOME/.profile"
  fi

  echo "Adding $BIN_DIR to PATH in $SHELL_PROFILE"
  echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$SHELL_PROFILE"
  echo "Please restart your terminal or run 'source $SHELL_PROFILE' to update your PATH."
fi

echo "Installation complete. You can test by running:"
echo "lua-language-server --help"
