#!/bin/bash

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source $BASE_DIR/scripts/installer/helper.sh

trap 'trap_message' INT TERM

log_message "Installation started"
print_bold_blue "\nSimple Hyprland"
echo "---------------"

check_root
check_os

run_script "prerequisites.sh" "Prerequisites Setup"
run_script "amd-hardware.sh" "AMD Radeon Drivers"
run_script "amd-microcode-boot.sh" "AMD Boot Integration"
run_script "hypr.sh" "Hyprland & Critical Softwares Setup"
run_script "utilities.sh" "Basic Utilities"
run_script "dev-tools.sh" "Development tools"
run_script "gaming.sh" "Gaming Configuration"
