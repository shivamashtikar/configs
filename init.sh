#!/bin/bash
# init script
echo "Shivam Ashtikar's init script"

# Function to show instructions for local scripts
local_script_instruction() {
    local script_name=$1
    echo "This script requires cloning the repository."
    echo "Please run the following commands:"
    echo
    echo "  git clone https://github.com/shivamashtikar/configs.git"
    echo "  cd configs"
    echo "  bash $script_name"
    echo
}

# Main function to select and run/show install instructions
install_script() {
    local options=(
        "--- One-Liners (can be run directly) ---"
        "Setup Figlet"
        "Setup Fira Code Fonts (macOS)"
        "Setup Fira Code Fonts (Linux)"
        "Setup fzf"
        "Setup Git Aliases (Termux)"
        "Update Neovim AppImage"
        "Setup Raspberry Pi"
        "--- Local Setup (requires repo clone) ---"
        "Setup Debian Server"
        "Setup Git Config"
        "Setup Kitty Terminal"
        "Setup Neovim"
        "Setup Neovim Server"
        "Setup Tmux"
        "Setup Ubuntu Apps"
        "Setup VSCode"
        "Setup Zsh"
        "Run All Setups"
    )

    local choice
    if command -v fzf &> /dev/null; then
        choice=$(printf "%s\n" "${options[@]}" | fzf --header "Select a script to install")
    else
        echo "fzf not found, using simple menu. For a better experience, please install fzf."
        echo "Select a script to install:"
        select opt in "${options[@]}"; do
            if [[ -n "$opt" ]]; then
                choice=$opt
                break
            else
                echo "Invalid selection. Please try again."
            fi
        done
    fi

    if [[ -z "$choice" ]]; then
        echo "No script selected."
        return
    fi

    case "$choice" in
        "--- One-Liners (can be run directly) ---"|"--- Local Setup (requires repo clone) ---")
            echo "Please select a script, not a category header. Please try again."
            ;;
        "Setup Figlet")
            echo "Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-figlet.sh | bash"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-figlet.sh | bash
            ;;
        "Setup Fira Code Fonts (macOS)")
            echo "Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fira-code-mac.sh | bash"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fira-code-mac.sh | bash
            ;;
        "Setup Fira Code Fonts (Linux)")
            echo "Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fira-code.sh | bash"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fira-code.sh | bash
            ;;
        "Setup fzf")
            echo "Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fzf.sh | bash"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fzf.sh | bash
            ;;
        "Setup Git Aliases (Termux)")
            echo "Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-termux.sh | bash"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-termux.sh | bash
            ;;
        "Update Neovim AppImage")
            echo "Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-nvim-appimage-update.sh | bash"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-nvim-appimage-update.sh | bash
            ;;
        "Setup Raspberry Pi")
            echo "Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup_raspberry_pi.sh | bash -s \"https://google.com\""
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup_raspberry_pi.sh | bash -s "https://google.com"
            ;;
        "Setup Debian Server") local_script_instruction "setup-debian.sh" ;; 
        "Setup Git Config") local_script_instruction "setup-gitconfig.sh" ;; 
        "Setup Kitty Terminal") local_script_instruction "setup-kitty.sh" ;; 
        "Setup Neovim") local_script_instruction "setup-nvim.sh" ;; 
        "Setup Neovim Server") local_script_instruction "setup-neovim-server.sh" ;; 
        "Setup Tmux") local_script_instruction "setup-tmux.sh" ;; 
        "Setup Ubuntu Apps") local_script_instruction "setup-ubuntu-apps.sh" ;; 
        "Setup VSCode") local_script_instruction "setup-vscode.sh" ;; 
        "Setup Zsh") local_script_instruction "setup-zsh.sh" ;; 
        "Run All Setups") local_script_instruction "setup.sh" ;; 
        *) 
            echo "Invalid choice."
            ;; 
    esac
}

install_script
