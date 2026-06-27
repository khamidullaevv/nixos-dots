#!/usr/bin/env bash

# ==========================================================
# Sairex Installer Library
# ==========================================================

# ---------- Colors ----------

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

# ---------- Banner ----------

banner() {

clear

printf "${PURPLE}"
cat <<'EOF'

   ███████╗ █████╗ ██╗██████╗ ███████╗██╗  ██╗
   ██╔════╝██╔══██╗██║██╔══██╗██╔════╝╚██╗██╔╝
   ███████╗███████║██║██████╔╝█████╗   ╚███╔╝
   ╚════██║██╔══██║██║██╔══██╗██╔══╝   ██╔██╗
   ███████║██║  ██║██║██║  ██║███████╗██╔╝ ██╗
   ╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

EOF

printf "${CYAN}                 NixOS Installer${RESET}\n"
printf "${GRAY}${LINE}${RESET}\n\n"

}

# ---------- UI ----------

section() {

echo
printf "${BLUE}${BOLD}▶ %s${RESET}\n" "$1"
printf "${GRAY}${LINE}${RESET}\n\n"

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

printf "${RED}✘${RESET} %s\n" "$1"
exit 1

}

divider() {

printf "${GRAY}${LINE}${RESET}\n"

}

pause() {

read -rp "Press ENTER to continue..."

}

# ---------- Step Runner ----------

run_step() {

local title="$1"
local script="$2"

section "$title"

if bash "$script"
then
    echo
    success "$title completed"
else
    echo
    error "$title failed"
fi

}

# ---------- Ask ----------

ask() {

local prompt="$1"
local default="$2"
local answer

if [[ -n "$default" ]]; then
    read -rp "$prompt [$default]: " answer
    echo "${answer:-$default}"
else
    read -rp "$prompt: " answer
    echo "$answer"
fi

}

# ---------- Yes / No ----------

confirm() {

local answer

while true
do

read -rp "$1 [Y/n]: " answer

case "$answer" in
    ""|Y|y|yes|YES)
        return 0
        ;;
    N|n|no|NO)
        return 1
        ;;
esac

done

}

# ---------- Finish ----------

finish() {

echo
divider
success "Installation completed successfully."
divider

}