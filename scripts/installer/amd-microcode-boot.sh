#!/bin/bash

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")
source $BASE_DIR/scripts/installer/helper.sh

log_message "Configuring AMD microcode boot integration"
print_info "\nConfiguring bootloader for amd-ucode..."

check_root
check_os

if [ -d /boot/grub ]; then
    print_info "Detected GRUB bootloader"

    run_command \
      "grub-mkconfig -o /boot/grub/grub.cfg" \
      "Regenerate GRUB config to include amd-ucode" \
      "yes"

elif [ -d /boot/loader/entries ]; then
    print_info "Detected systemd-boot"

    if [ ! -f /boot/amd-ucode.img ]; then
        print_error "amd-ucode image not found at /boot/amd-ucode.img"
        print_error "Install amd-ucode before configuring the bootloader"
        exit 1
    fi

    for entry in /boot/loader/entries/*.conf; do
        if ! grep -q '^initrd[[:space:]]\+/amd-ucode.img$' "$entry"; then
            sed -i '/^initrd[[:space:]]\+\/initramfs-linux.img/i initrd /amd-ucode.img' "$entry"
        fi
    done

else
    print_error "No supported bootloader detected (GRUB or systemd-boot)"
    print_error "amd-ucode installed but NOT wired into boot"
    exit 1
fi

print_success "AMD microcode boot configuration complete"
echo "------------------------------------------------------------------------"
