#!/bin/bash
set -x


if [ -d "$HOME/Library/Application\ Support/" ]; then
  VSCODE_DIR=$HOME/Library/Application\ Support/Code/User
else
  VSCODE_DIR=$HOME/.config/Code/User
fi
mkdir -p $VSCODE_DIR
ln -s $PWD/vscode/keybindings.json $VSCODE_DIR/keybindings.json
ln -s $PWD/vscode/settings.json $VSCODE_DIR/settings.json
