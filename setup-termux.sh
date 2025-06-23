#!/bin/bash

# Function to detect the user's shell and return the corresponding rc file
get_shell_config_file() {
  if [ -n "$ZSH_VERSION" ]; then
    echo "$HOME/.zshrc"
  elif [ -n "$BASH_VERSION" ]; then
    echo "$HOME/.bashrc"
  else
    # Fallback for other shells, may need manual user intervention
    echo "$HOME/.profile"
  fi
}

# Determine the correct shell configuration file
CONFIG_FILE=$(get_shell_config_file)

# Define the block of aliases to be added
ALIASES_BLOCK=$(cat <<'EOF'
# Git Aliases from shivamashtikar/configs
alias gst='git status'
alias gl='git pull'
alias gpr='git pull --rebase'
alias gp='git push'
alias gpf!='git push --force'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gd='git diff'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grbd='git rebase $(git_develop_branch)'
alias grbm='git rebase $(git_main_branch)'
EOF
)

# Check if the aliases are already in the config file to avoid duplicates
if grep -q "# Git Aliases from shivamashtikar/configs" "$CONFIG_FILE"; then
  echo "Git aliases already found in $CONFIG_FILE. No changes made."
else
  echo "Adding Git aliases to $CONFIG_FILE..."
  # Append the aliases block to the config file
  echo "" >> "$CONFIG_FILE" # Add a newline for spacing
  echo "$ALIASES_BLOCK" >> "$CONFIG_FILE"
  echo "Aliases added successfully."
  echo ""
  echo "Please restart your shell or run 'source $CONFIG_FILE' to apply the changes."
fi
