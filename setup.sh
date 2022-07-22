#!/bin/bash

PACKER_FILE=~/.local/share/nvim/site/pack/packer/start/packer.nvim
if [[ -f $PACKER_FILE ]]
then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_FILE
else
  echo "$PACKER_FILE already exists!"
  echo "Proceeding with setup"
fi

nvim -c 'PackerInstall'

mkdir -p ~/.config/nvim
ln -s $(pwd)/plugin $HOME/.config/nvim/plugin
ln -s $(pwd)/lua $HOME/.config/nvim/lua
ln -s $(pwd)/init.lua $HOME/.config/nvim/init.lua
