#!/bin/bash

# Get the directory of the current script
BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

# Source helper file
source $BASE_DIR/scripts/installer/helper.sh

log_message "Installation started for prerequisites section"
print_info "\nStarting prerequisites setup..."

run_command "pacman -Syyu --noconfirm" "Update package database and upgrade packages (Recommended)" "yes" # no

run_command "pacman -S --noconfirm git" "Install git" "yes"
run_command "git config --global user.name \"Diogo Lundberg\"" "Configure git user name" "yes"
run_command "git config --global user.email \"dclundberg@gmail.com\"" "Configure git user email" "yes"

if ! command -v yay > /dev/null; then
    run_command "pacman -S --noconfirm --needed base-devel" "Install yay build deps" "yes"
    run_command "rm -rf /tmp/yay && git clone https://aur.archlinux.org/yay.git /tmp/yay" "Clone yay" "yes" "no"
    run_command "bash -lc 'cd /tmp/yay && makepkg -si --noconfirm'" "Build and install yay" "yes" "no"
    run_command "rm -rf /tmp/yay" "Cleanup yay build directory" "yes" "no"
fi

run_command "pacman -S --noconfirm pipewire wireplumber pamixer brightnessctl" "Configuring audio and brightness (Recommended)" "yes"

run_command "pacman -S --noconfirm ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono" "Installing Nerd Fonts and Symbols (Recommended)" "yes"

run_command "pacman -S --noconfirm ly && systemctl enable ly@tty1.service" "Install and enable ly (Recommended)" "yes"

run_command "yay -S --sudoloop --noconfirm brave-bin" "Install Brave Browser" "yes" "no"

run_command "pacman -S --noconfirm ghostty" "Install Ghostty (Recommended)" "yes"

run_command "pacman -S --noconfirm vim" "Install vim" "yes"

run_command "pacman -S --noconfirm tar" "Install tar for extracting files (Must)/needed for copying themes" "yes"

echo "------------------------------------------------------------------------"
