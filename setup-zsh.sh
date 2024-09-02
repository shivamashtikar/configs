#!/bin/bash
set -x

echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Linking ZSH configs"
ln -s ~/workspace/i3-dot-files/zshrc ~/.zshrc
ln -s ~/workspace/i3-dot-files/oh-my-zsh/custom/themes/agnoster-new-line.zsh-theme ~/.oh-my-zsh/themes/agnoster-new-line.zsh-theme

echo "Installing ZSH autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing ZSH syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

