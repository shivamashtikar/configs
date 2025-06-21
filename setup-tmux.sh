#!/bin/bash

# Exit on any error
set -ea

# Get the directory where this script is located (should be the root of your 'configs' repo)
SUBMODULE_DIR="../easy-tmux"

if [ ! -d "$SUBMODULE_DIR" ]; then
  echo "Cloning 'easy-tmux' to ../easy-tmux location"
  git clone https://github.com/shivamashtikar/easy-tmux.git $SUBMODULE_DIR
else 

  echo "Directory ${SUBMODULE_DIR} exists" 
fi

cd $SUBMODULE_DIR
pwd

# 2. Run the setup script from within the 'easy-tmux' submodule
if  [ -f "$SUBMODULE_DIR/setup.sh" ]; then
    echo "Running setup script from 'easy-tmux' submodule..."
    bash setup.sh # Run setup.sh from within its own directory context
    echo "'easy-tmux' setup script finished."
else
    echo "Error: setup.sh not found in $SUBMODULE_DIR."
    exit 1
fi




read -p "Do you want to configure ssh remote url? (y/n): " yn


case $yn in
  [Yy]* )
    git remote set-url origin git@github.com:shivamashtikar/easy-tmux.git;;
  [Nn]* )
    echo "Skipping remote configuration"
    break;;

  * ) echo "Please answer yes (y) or no (n).";;
esac

echo ""
echo "Tmux setup using 'easy-tmux' submodule complete!"
echo "If this is a fresh setup, open tmux and press Ctrl+b I (uppercase i) to install TPM plugins."
