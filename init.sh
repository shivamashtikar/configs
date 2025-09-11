#!/bin/bash
# init script

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}Shivam Ashtikar's init script${NC}"

# Function to show instructions for local scripts
local_script_instruction() {
    local script_name=$1
    echo -e "${YELLOW}This script requires cloning the repository.${NC}"
    echo "Please run the following commands:"
    echo
    echo -e "  ${CYAN}git clone https://github.com/shivamashtikar/configs.git${NC}"
    echo -e "  ${CYAN}cd configs${NC}"
    echo -e "  ${CYAN}bash $script_name${NC}"
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
        echo -e "${YELLOW}fzf not found, using simple menu. For a better experience, please install fzf.${NC}"
        echo "Select a script to install:"
        select opt in "${options[@]}"; do
            if [[ -n "$opt" ]]; then
                choice=$opt
                break
            else
                echo -e "${RED}Invalid selection. Please try again.${NC}"
            fi
        done
    fi

    if [[ -z "$choice" ]]; then
        echo -e "${RED}No script selected.${NC}"
        return
    fi

    case "$choice" in
        "--- One-Liners (can be run directly) ---"|"--- Local Setup (requires repo clone) ---")
            echo -e "${YELLOW}Please select a script, not a category header. Please try again.${NC}"
            ;;
        "Setup Figlet")
            echo -e "${GREEN}Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-figlet.sh | bash${NC}"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-figlet.sh | bash
            ;;
        "Setup Fira Code Fonts (macOS)")
            echo -e "${GREEN}Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fira-code-mac.sh | bash${NC}"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fira-code-mac.sh | bash
            ;;
        "Setup Fira Code Fonts (Linux)")
            echo -e "${GREEN}Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fira-code.sh | bash${NC}"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fira-code.sh | bash
            ;;
        "Setup fzf")
            echo -e "${GREEN}Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fzf.sh | bash${NC}"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fzf.sh | bash
            ;;
        "Setup Git Aliases (Termux)")
            echo -e "${GREEN}Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-termux.sh | bash${NC}"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-termux.sh | bash
            ;;
        "Update Neovim AppImage")
            echo -e "${GREEN}Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-nvim-appimage-update.sh | bash${NC}"
            curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-nvim-appimage-update.sh | bash
            ;;
        "Setup Raspberry Pi")
            echo -e "${GREEN}Running: curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup_raspberry_pi.sh | bash -s \"https://google.com\"${NC}"
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
            echo -e "${RED}Invalid choice.${NC}"
            ;; 
    esac
}

install_script