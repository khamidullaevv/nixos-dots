#!/usr/bin/env bash

set -Eeuo pipefail

# ==========================================================
# Sairex NixOS Installer Library
# ==========================================================

# ----------------------------------------------------------
# Paths
# ----------------------------------------------------------

INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(realpath "$INSTALLER_DIR/../..")"

STATE_DIR="$INSTALLER_DIR/state"
OUTPUT_DIR="$INSTALLER_DIR/output"
TEMPLATE_DIR="$INSTALLER_DIR/templates"
GENERATOR_DIR="$INSTALLER_DIR/generators"

mkdir -p \
    "$STATE_DIR" \
    "$OUTPUT_DIR"

# ----------------------------------------------------------
# Colors
# ----------------------------------------------------------

RESET="\033[0m"
BOLD="\033[1m"

RED="\033[38;5;196m"
GREEN="\033[38;5;82m"
YELLOW="\033[38;5;220m"
BLUE="\033[38;5;39m"
PURPLE="\033[38;5;141m"
CYAN="\033[38;5;51m"
GRAY="\033[38;5;245m"

LINE="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ----------------------------------------------------------
# Banner
# ----------------------------------------------------------

banner() {

clear

printf "${PURPLE}"

cat << "EOF"

   ███████╗ █████╗ ██╗██████╗ ███████╗██╗  ██╗
   ██╔════╝██╔══██╗██║██╔══██╗██╔════╝╚██╗██╔╝
   ███████╗███████║██║██████╔╝█████╗   ╚███╔╝
   ╚════██║██╔══██║██║██╔══██╗██╔══╝   ██╔██╗
   ███████║██║  ██║██║██║  ██║███████╗██╔╝ ██╗
   ╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

EOF

printf "${CYAN}                 NixOS Installer${RESET}\n"
printf "${GRAY}%s${RESET}\n\n" "$LINE"

}

logo() {
    banner
}

# ----------------------------------------------------------
# UI
# ----------------------------------------------------------

section() {

printf "\n${BLUE}${BOLD}▶ %s${RESET}\n" "$1"
printf "${GRAY}%s${RESET}\n\n" "$LINE"

}

info() {
    printf "${CYAN}●${RESET} %s\n" "$1"
}

success() {
    printf "${GREEN}✔${RESET} %s\n" "$1"
}

warning() {
    printf "${YELLOW}▲${RESET} %s\n" "$1"
}

error() {
    printf "\n${RED}✘${RESET} %s\n" "$1"
    exit 1
}

# ----------------------------------------------------------
# Prompt
# ----------------------------------------------------------

ask() {

local prompt="$1"
local default="${2:-}"

if [[ -n "$default" ]]; then
    read -rp "$prompt [$default]: " value
    echo "${value:-$default}"
else
    read -rp "$prompt: " value
    echo "$value"
fi

}

# ----------------------------------------------------------
# Template Engine
# ----------------------------------------------------------

render_template() {

    local template="$1"
    local output="$2"

    [[ -f "$template" ]] \
        || error "Template not found: $template"

    source "$STATE_DIR/config.env"

    cp "$template" "$output"

    while IFS='=' read -r key value; do

        value="${value%\"}"
        value="${value#\"}"

        sed -i "s|__${key}__|$value|g" "$output"

    done < "$STATE_DIR/config.env"

}

# ----------------------------------------------------------
# Runner
# ----------------------------------------------------------

run_step() {

local title="$1"
local script="$2"

section "$title"

if bash "$script"; then
    echo
    success "$title completed"
else
    error "$title failed"
fi

}

# ----------------------------------------------------------
# Utilities
# ----------------------------------------------------------

require_command() {

command -v "$1" >/dev/null 2>&1 \
    || error "'$1' is required."

}

require_root() {

[[ $EUID -eq 0 ]] \
    || error "Run this command as root."

}

ensure_dir() {
    mkdir -p "$1"
}

# ----------------------------------------------------------
# Finish
# ----------------------------------------------------------

finished() {

echo
printf "${GREEN}${BOLD}✔ Installation completed successfully.${RESET}\n"

}