#!/bin/bash

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for hypr section"
print_info "\nStarting Hyprland setup..."
print_info "\nEverything is recommended to INSTALL"

check_root
check_os

run_command "pacman -S --noconfirm --needed hyprland xorg-xwayland" "Install Hyprland + XWayland (Must for compatibility)" "yes"

run_command "pacman -S --noconfirm --needed xdg-desktop-portal-hyprland" "Install XDG desktop portal for Hyprland" "yes"

run_command "pacman -S --noconfirm polkit-gnome" "Install GNOME Polkit agent for authentication dialogs" "yes"

run_command "pacman -S --noconfirm --needed qt5-wayland qt6-wayland" "Install Qt Wayland support (reduce XWayland fallback)" "yes"

run_command "mkdir -p /home/$SUDO_USER/.config/hypr/ && cp -r $BASE_DIR/configs/hypr/hyprland.conf /home/$SUDO_USER/.config/hypr/" "Copy hyprland config (Must)" "yes" "no"

run_command "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/hypr" "Fix ownership for Hypr config" "no" "yes"

echo "------------------------------------------------------------------------"
