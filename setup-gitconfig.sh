#!/bin/bash
set -x

git config --global core.ignorecase false
git config --global core.editor nvim
git config --global push.autoSetupRemote true

read -p "Enter your name: " INPUT_NAME
git config --global user.name "$INPUT_NAME"

read -p "Enter your email: " INPUT_EMAIL
git config --global user.email "$INPUT_EMAIL"
