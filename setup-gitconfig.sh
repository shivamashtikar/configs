#!/bin/bash

git config --global core.ignorecase false
git config --global core.editor nvim
git config --global push.autoSetupRemote true

# Check for existing user name and email
EXISTING_NAME=$(git config --global --get user.name || echo "")
EXISTING_EMAIL=$(git config --global --get user.email || echo "")

UPDATE_DETAILS="n"

if [ -n "$EXISTING_NAME" ] && [ -n "$EXISTING_EMAIL" ]; then
    echo "Found existing git config:"
    echo "  Name:  $EXISTING_NAME"
    echo "  Email: $EXISTING_EMAIL"
    read -p "Do you want to update them? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        UPDATE_DETAILS="y"
    fi
else
    echo "No existing user name and email found."
    UPDATE_DETAILS="y"
fi

if [ "$UPDATE_DETAILS" = "y" ]; then
    read -p "Enter your name: " INPUT_NAME
    git config --global user.name "$INPUT_NAME"

    read -p "Enter your email: " INPUT_EMAIL
    git config --global user.email "$INPUT_EMAIL"
fi

# Alias for Gemini commit
echo "Setting up git alias 'gcommit'..."
# Get the absolute path to the helper script
HELPER_SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)/scripts/gcommit-helper.sh"
git config --global alias.gcommit "!$HELPER_SCRIPT_PATH"
echo "Alias 'gcommit' created. Run with 'git gcommit'."