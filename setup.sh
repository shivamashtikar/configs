#!/bin/bash

PACKER_FILE=~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_FILE

nvim -c 'PackerInstall'

mkdir -p ~/.config/nvim
ln -s $(pwd)/plugin $HOME/.config/nvim/plugin
ln -s $(pwd)/lua $HOME/.config/nvim/lua
ln -s $(pwd)/init.lua $HOME/.config/nvim/init.lua
