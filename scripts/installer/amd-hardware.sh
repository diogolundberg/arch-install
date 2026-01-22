#!/bin/bash

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for AMD Radeon drivers section"
print_info "\nStarting AMD Radeon (RDNA2) driver stack setup..."

check_root
check_os

run_command "pacman -S --noconfirm --needed linux-firmware amd-ucode" "Install firmware and AMD CPU microcode (Recommended)" "yes"

run_command "pacman -S --noconfirm --needed mesa lib32-mesa libdrm lib32-libdrm libglvnd lib32-libglvnd" "Install Mesa/DRM OpenGL stack (64-bit + 32-bit) (Must)" "yes"

run_command "pacman -S --noconfirm --needed vulkan-radeon vulkan-icd-loader lib32-vulkan-radeon lib32-vulkan-icd-loader" "Install Vulkan RADV stack (64-bit + 32-bit) (Required for Steam/Proton)" "yes"

run_command "pacman -S --noconfirm --needed libva-mesa-driver libva-utils" "Install VA-API video acceleration (Recommended)" "yes"

run_command "pacman -S --noconfirm --needed mesa-utils vulkan-tools" "Install graphics diagnostics tools (Recommended)" "yes"

print_success "\nAMD Radeon driver stack installed."
print_info "\nVerification commands:"
print_info "  glxinfo -B"
print_info "  vulkaninfo --summary"

echo "------------------------------------------------------------------------"
