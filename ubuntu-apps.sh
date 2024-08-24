#!/bin/bash
set -x

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update

sudo apt install \
  neovim\
  chrome-gnome-shell\
  htop\
  git\
  tmux\
  kitty\
  curl\
  zsh\
  ranger\
  lolcat\
  figlet\
  jq\
  qbittorrent\
  fzf

snap install spotify postman
snap install obsidian --classic
