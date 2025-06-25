#!/bin/bash

# ==============================================================================
# Script to set up a Raspberry Pi for Kiosk Mode and optimize swap memory.
# ==============================================================================

# --- Function to set up swap memory ---
setup_swap() {
    echo "--- Updating Swap Memory ---"

    # Get total RAM in MB
    ram_mb=$(free -m | awk '/^Mem:/{print $2}')
    if [ -z "$ram_mb" ]; then
        echo "Error: Could not determine RAM size."
        exit 1
    fi

    # Calculate new swap size (2x RAM)
    swap_size=$((ram_mb * 2))
    echo "RAM detected: ${ram_mb}MB. Setting swap size to ${swap_size}MB."

    # Backup original config
    if [ -f "/etc/dphys-swapfile" ]; then
        sudo cp /etc/dphys-swapfile /etc/dphys-swapfile.bak
        echo "Backed up /etc/dphys-swapfile to /etc/dphys-swapfile.bak"
    fi

    # Update swap size in config file
    sudo sed -i "s/^[# ]*CONF_SWAPSIZE=.*/CONF_SWAPSIZE=${swap_size}/" /etc/dphys-swapfile
    
    # Restart dphys-swapfile service
    echo "Restarting swap service..."
    sudo /etc/init.d/dphys-swapfile stop
    sudo /etc/init.d/dphys-swapfile start

    echo "Swap memory setup complete."
    echo
}

# --- Function to set up kiosk mode ---
setup_kiosk() {
    echo "--- Configuring Kiosk Mode ---"

    local kiosk_url=$1

    # Validate URL input
    if [ -z "$kiosk_url" ]; then
        echo "Error: URL argument is missing."
        echo "Usage: bash setup_raspberry_pi.sh <kiosk_url>"
        exit 1
    fi

    echo "Using URL: $kiosk_url"

    # Define autostart file path
    autostart_dir="$HOME/.config/lxsession/LXDE-pi"
    autostart_file="$autostart_dir/autostart"

    # Create directory if it doesn't exist
    echo "Ensuring autostart directory exists at $autostart_dir..."
    mkdir -p "$autostart_dir"

    # Create the autostart file
    echo "Creating autostart file at $autostart_file..."
    cat <<EOF > "$autostart_file"
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xscreensaver -no-splash
@sleep 5
@chromium-browser --kiosk $kiosk_url
EOF

    echo "Kiosk mode configuration complete."
    echo
}

# --- Main script execution ---
main() {
    echo "Starting Raspberry Pi setup..."
    echo

    setup_swap
    setup_kiosk "$1"

    echo "========================================================"
    echo "Setup is complete!"
    echo "Please reboot your Raspberry Pi for the changes to take full effect."
    echo "You can reboot by running: sudo reboot"
    echo "========================================================"
}

# Run the main function
main "$1"
