# configs
Personal Development Environment

![nvim](./assets/nvim.png)

![pane](./assets/pane.png)

![git-status](./assets/git-status-popup.png)

![undo-tree](./assets/undo-tree.png)

# Setup

## Quick Setup One-Liners

These scripts are designed to be self-contained and can be executed directly as one-liners without requiring user interaction.

### Setup Figlet

```bash
curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-figlet.sh | bash
```

### Setup Fira Code Fonts (macOS)

```bash
curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fira-code-mac.sh | bash
```

### Setup Fira Code Fonts (Linux)

```bash
curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fira-code.sh | bash
```

### Setup fzf

```bash
curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-fzf.sh | bash
```

### Setup Git Aliases

```bash
curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-termux.sh | bash
```

### Update Neovim AppImage

```bash
curl -sSL https://raw.githubusercontent.com/shivamashtikar/configs/main/setup-nvim-appimage-update.sh | bash
```

## Local Setup (Requires Repository Clone)

These scripts depend on other configuration files, submodules, or require user interaction. To use them, you must first clone the entire repository.

```bash
git clone https://github.com/shivamashtikar/configs.git
cd configs
```

After cloning and navigating into the `configs` directory, you can run the following setup scripts:

### Setup Debian Server

```bash
bash setup-debian.sh
```

### Setup Git Config

```bash
bash setup-gitconfig.sh
```

### Setup Kitty Terminal

```bash
bash setup-kitty.sh
```

### Setup Neovim

```bash
bash setup-nvim.sh
```

### Setup Neovim Server

```bash
bash setup-neovim-server.sh
```

### Setup Tmux

```bash
bash setup-tmux.sh
```

### Setup Ubuntu Apps

```bash
bash setup-ubuntu-apps.sh
```

### Setup VSCode

```bash
bash setup-vscode.sh
```

### Setup Zsh

```bash
bash setup-zsh.sh
```

### Run All Setups

This script will attempt to run all other setup scripts.

```bash
bash setup.sh
