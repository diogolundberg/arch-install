#!/bin/bash

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for utilities section"
print_info "\nStarting utilities setup..."

check_root
check_os

run_command "pacman -S --noconfirm --needed fuzzel" "Install Fuzzel (Launcher used by hyprland.conf)" "yes"

run_command "pacman -S --noconfirm --needed wl-clipboard" "Install wl-clipboard (Required: wl-copy used by hyprland.conf)" "yes"

run_command "yay -S --sudoloop --noconfirm --needed grimblast-git" "Install grimblast (Screenshots for hyprland.conf)" "yes" "no"
run_command "mkdir -p /home/$SUDO_USER/screenshots" "Create screenshots folder" "no" "yes"
run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/screenshots" "Fix ownership for screenshots folder" "no" "yes"

run_command "pacman -S --noconfirm --needed thunar" "Install Thunar (File manager used by hyprland.conf)" "yes"

run_command "pacman -S --noconfirm --needed pavucontrol" "Install pavucontrol (Recommended: audio routing GUI)" "yes"

run_command "pacman -S --noconfirm --needed mission-center" "Install Mission Center (Graphical process monitor)" "yes"

run_command "pacman -S --noconfirm --needed htop" "Install htop (Terminal process monitor)" "yes"

run_command "pacman -S --noconfirm --needed btop" "Install btop (Visual terminal system monitor)" "yes"

run_command "pacman -S --noconfirm --needed networkmanager" "Install NetworkManager (Recommended: network management)" "yes"
run_command "systemctl enable --now NetworkManager" "Enable NetworkManager" "yes"

echo "------------------------------------------------------------------------"
