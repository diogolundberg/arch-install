#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

: "${BASE_DIR:?BASE_DIR must be set by the calling script}"

LOG_FILE="$BASE_DIR/scripts/installer/simple_hyprland_install.log"

trap 'print_error "\nScript interrupted"; exit 1' INT TERM

log_message() {
    echo "$(date): $1" >> "$LOG_FILE"
}

print_error()   { echo -e "${RED}$1${NC}"; }
print_success() { echo -e "${GREEN}$1${NC}"; }
print_warning() { echo -e "${YELLOW}$1${NC}"; }
print_info()    { echo -e "${BLUE}$1${NC}"; }

ask_confirmation() {
    while true; do
        read -rp "$(print_warning "$1 (y/n): ")" -n 1
        echo
        case "$REPLY" in
            [Yy]) return 0 ;;
            [Nn]) print_error "Operation cancelled."; return 1 ;;
            *) print_error "Invalid input." ;;
        esac
    done
}

check_root() {
    [ "$EUID" -eq 0 ] || { print_error "Run as root"; exit 1; }
    SUDO_USER="${SUDO_USER:-$(logname)}"
}

run_command() {
    local cmd="$1"
    local description="$2"
    local ask_confirm="${3:-yes}"
    local as_user="${4:-root}"

    log_message "Running: $description"
    print_info "\n$description"

    if [[ "$ask_confirm" == "yes" ]]; then
        ask_confirmation "$description" || return 1
    fi

    if [[ "$as_user" == "user" ]]; then
        sudo -u "$SUDO_USER" bash -lc "$cmd"
    else
        bash -lc "$cmd"
    fi

    local rc=$?
    if [[ $rc -ne 0 ]]; then
        print_error "Command failed"
        log_message "FAILED: $cmd"
        return $rc
    fi

    print_success "Done"
    log_message "SUCCESS: $cmd"
}

run_script() {
    local script="$BASE_DIR/scripts/installer/$1"
    local description="$2"
    ask_confirmation "Run $description?" || return 1
    bash "$script"
}
