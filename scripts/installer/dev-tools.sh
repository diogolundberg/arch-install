#!/bin/bash

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for dev applications section"
print_info "\nStarting dev applications setup..."

check_root
check_os

if ! command -v yay >/dev/null 2>&1; then
    print_error "yay is required to install Sublime Text (AUR) but was not found."
    print_error "Run prerequisites.sh first."
    exit 1
fi

run_command "pacman -S --noconfirm --needed zed" "Install Zed editor (used by hyprland.conf)" "yes"
run_command "mkdir -p /home/$SUDO_USER/.local/bin" "Create ~/.local/bin for user" "no" "yes"
run_command "ln -sf /usr/bin/zeditor /home/$SUDO_USER/.local/bin/zed" "Expose Zed as 'zed' command" "no" "yes"

run_command "yay -S --sudoloop --noconfirm --needed sublime-text-4" "Install Sublime Text (used by hyprland.conf)" "yes" "no"

run_command "pacman -S --noconfirm --needed starship mise eza" "Install starship + mise + eza" "yes"

run_command "cp $BASE_DIR/configs/shell/.bashrc /home/$SUDO_USER/.bashrc" "Overwrite .bashrc from repo" "yes" "yes"

run_command "chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.bashrc" "Fix ownership for .bashrc" "no" "yes"

run_command "pacman -S --noconfirm --needed fastfetch" "Install Fastfetch" "yes"

echo "------------------------------------------------------------------------"
