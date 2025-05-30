#!/bin/bash
set -x

mkdir -p $HOME/Library/Application\ Support/Code/User/
ln -s $PWD/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
ln -s $PWD/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
