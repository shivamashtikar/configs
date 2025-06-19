#!/bin/bash

# Ensure all scripts are executable
chmod +x ./*.sh

# Function to check OS family
get_os_family() {
  case "$(uname -s)" in
    Linux*)
      if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID_LIKE" == *"debian"* || "$ID" == "debian" || "$ID" == "ubuntu" ]]; then
          echo "Debian" # Covers Debian, Ubuntu, and derivatives
        elif [[ "$ID_LIKE" == *"arch"* || "$ID" == "arch" ]]; then
          echo "Arch"
        else
          echo "Linux" # Generic Linux
        fi
      else
        echo "Linux" # Generic Linux if /etc/os-release is not found
      fi
      ;;
    Darwin*)
      echo "Darwin" # macOS
      ;;
    *)
      echo "Unknown"
      ;;
  esac
}

# Function to check if running in Termux
is_termux() {
  if [[ -n "$TERMUX_VERSION" ]]; then
    return 0 # True, is Termux
  else
    return 1 # False, not Termux
  fi
}

OS_FAMILY=$(get_os_family)
IN_TERMUX=$(is_termux && echo "true" || echo "false")

echo "----------------------------------------"
echo "Starting System Setup"
echo "----------------------------------------"
echo "Detected OS Family: $OS_FAMILY"
if [[ "$IN_TERMUX" == "true" ]]; then
  echo "Detected Termux environment."
fi
echo "----------------------------------------"

run_script() {
  local script_name="$1"
  local script_path="./${script_name}"
  
  if [ -f "$script_path" ]; then
    echo "Running $script_name with bash..." # Updated message
    bash "$script_path" # Changed to explicitly use bash
    echo "$script_name finished."
    # The check for executable permission is less critical now but can be kept for informational purposes
    # if [ ! -x "$script_path" ]; then
    #   echo "INFO: $script_name did not have execute permissions. Executed with bash."
    # fi
  else
    echo "WARNING: $script_name not found. Skipping."
  fi
  echo "----------------------------------------"
}

# --- Generic Scripts ---
# It's generally good practice to set up core configurations first.
# The order below is a suggestion. You can adjust it based on dependencies.

echo "Running core configuration scripts..."
run_script "setup-gitconfig.sh"

echo "Running shell setup scripts..."
run_script "setup-zsh.sh"      # Often best run early or very late

echo "Running essential tool setup scripts..."
run_script "setup-fzf.sh"

echo "Running editor setup scripts..."
run_script "setup-nvim.sh"
run_script "setup-neovim-server.sh"
run_script "setup-nvim-appimage-update.sh"
run_script "setup-vscode.sh"

echo "Running terminal enhancement scripts..."
run_script "setup-kitty.sh"
run_script "setup-tmux.sh"
run_script "setup-figlet.sh"   # More for fun, less critical

echo "Running generic font setup scripts..."
run_script "setup-fira-code.sh"

# --- OS-Specific Scripts ---
echo "Running OS-specific setup scripts..."

if [[ "$OS_FAMILY" == "Darwin" ]]; then
  echo "Executing macOS specific scripts..."
  run_script "setup-fira-code-mac.sh"
  # Add other Mac-specific scripts here if they exist, e.g.:
  # run_script "setup-brew.sh"
fi

if [[ "$OS_FAMILY" == "Debian" ]]; then
  echo "Executing Debian/Ubuntu specific scripts..."
  run_script "setup-debian.sh" # General Debian-based setup
  
  # Check specifically for Ubuntu for Ubuntu-only scripts
  if [ -f /etc/os-release ] && grep -q -i "ID=ubuntu" /etc/os-release; then
    echo "Executing Ubuntu specific scripts..."
    run_script "setup-ubuntu-apps.sh"
  fi
  # Add other Debian/Ubuntu-specific scripts here if they exist
fi

# Add conditions for other OS families like Arch if needed
# if [[ "$OS_FAMILY" == "Arch" ]]; then
#   echo "Executing Arch Linux specific scripts..."
#   run_script "setup-arch-specific.sh"
# fi

# --- Termux-Specific Scripts ---
if [[ "$IN_TERMUX" == "true" ]]; then
  echo "Running Termux specific scripts..."
  run_script "setup-termux.sh"
fi

echo "----------------------------------------"
echo "All setup scripts processed."
echo "Review output for any warnings or errors."
echo "----------------------------------------"
