#!/bin/bash

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for gaming section"
print_info "\nStarting gaming setup..."

check_root
check_os

run_command "pacman -S --noconfirm --needed steam" "Install Steam" "yes"

run_command "pacman -S --noconfirm --needed gamemode lib32-gamemode" "Install GameMode (Recommended)" "yes"

run_command "pacman -S --noconfirm --needed mangohud lib32-mangohud" "Install MangoHud (Recommended)" "yes"

run_command "pacman -S --noconfirm --needed lib32-alsa-plugins" "Install 32-bit ALSA plugins (Recommended for some games)" "yes"

echo "------------------------------------------------------------------------"
