#!/bin/bash

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for prerequisites section"
print_info "\nStarting prerequisites setup..."

check_root
check_os

run_command "grep -qE '^[[:space:]]*\\[multilib\\][[:space:]]*$' /etc/pacman.conf" "Verify multilib is enabled (Must)" "yes"
run_command "pacman -Syyu --noconfirm" "Update package database and upgrade packages (Recommended)" "yes"

run_command "pacman -S --noconfirm git" "Install git" "yes"
run_command "git config --global user.name \"Diogo Lundberg\"" "Configure git user name" "yes"
run_command "git config --global user.email \"dclundberg@gmail.com\"" "Configure git user email" "yes"

if command -v yay > /dev/null; then
    print_info "Skipping yay installation (already installed)."
elif run_command "pacman -S --noconfirm --needed base-devel" "Install YAY (Must)/Breaks the script" "yes"; then
    run_command "git clone https://aur.archlinux.org/yay.git && cd yay" "Clone YAY (Must)/Breaks the script" "no" "no"
    run_command "makepkg --noconfirm -si && cd .. # builds with makepkg" "Build YAY (Must)/Breaks the script" "no" "no"
fi

run_command "pacman -S --noconfirm --needed pipewire wireplumber pipewire-pulse pipewire-alsa alsa-utils pamixer brightnessctl" "Configuring audio and brightness (Recommended)" "yes"

run_command "pacman -S --noconfirm ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono" "Installing Nerd Fonts and Symbols (Recommended)" "yes"

run_command "pacman -S --noconfirm ly && systemctl enable ly@tty1.service" "Install and enable ly (Recommended)" "yes"

run_command "yay -S --sudoloop --noconfirm brave-bin" "Install Brave Browser" "yes" "no"

run_command "pacman -S --noconfirm --needed ghostty ghostty-terminfo ghostty-shell-integration" "Install Ghostty (+ terminfo + shell integration) (Recommended)" "yes"

run_command "pacman -S --noconfirm --needed less" "Install less (pager utility)" "yes"

run_command "pacman -S --noconfirm vim" "Install vim" "yes"

run_command "pacman -S --noconfirm tar" "Install tar for extracting files (Must)/needed for copying themes" "yes"

echo "------------------------------------------------------------------------"
