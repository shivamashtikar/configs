#!/bin/bash

# Exit on any error
set -e

# Get the directory where this script is located (should be the root of your 'configs' repo)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUBMODULE_DIR="$SCRIPT_DIR/easy-tmux"

echo "Starting tmux setup using 'easy-tmux' submodule..."

# 1. Ensure the submodule is initialized and up-to-date
echo "Initializing/updating 'easy-tmux' submodule..."
if [ -d "$SUBMODULE_DIR/.git" ]; then
    # If submodule directory exists and is a git repo, update it
    (cd "$SCRIPT_DIR" && git submodule update --init --recursive "$SUBMODULE_DIR")
else
    # If submodule directory doesn't exist or isn't a git repo, try to init/update (might happen if cloned without --recurse-submodules)
    (cd "$SCRIPT_DIR" && git submodule update --init --recursive "$SUBMODULE_DIR")
    if [ ! -d "$SUBMODULE_DIR/.git" ]; then
        echo "Error: 'easy-tmux' submodule not found or failed to initialize at $SUBMODULE_DIR."
        echo "Please ensure it's correctly added and initialized: git submodule update --init --recursive"
        exit 1
    fi
fi
echo "'easy-tmux' submodule is ready."

# 2. Run the setup script from within the 'easy-tmux' submodule
if [ -f "$SUBMODULE_DIR/setup.sh" ]; then
    echo "Running setup script from 'easy-tmux' submodule..."
    (cd "$SUBMODULE_DIR" && bash setup.sh) # Run setup.sh from within its own directory context
    echo "'easy-tmux' setup script finished."
else
    echo "Error: setup.sh not found in $SUBMODULE_DIR."
    exit 1
fi

echo ""
echo "Tmux setup using 'easy-tmux' submodule complete!"
echo "If this is a fresh setup, open tmux and press Ctrl+b I (uppercase i) to install TPM plugins."
