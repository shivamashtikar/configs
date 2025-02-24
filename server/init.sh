#!/bin/bash
set +x

echo "Install script for ubuntu server"

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y tmux zsh neovim htop ranger fzf curl


