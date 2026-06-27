#!/usr/bin/env bash

set -e

# ==========================================================
# Sairex Installer Library
# ==========================================================

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

clear_screen() {
    clear
}

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

printf "${CYAN}                 NixOS Installer\n"
printf "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n\n"
}

section() {

printf "\n${BLUE}${BOLD}▶ %s${RESET}\n" "$1"
printf "${GRAY}%s${RESET}\n" "$LINE"

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

step() {

printf "\n${PURPLE}[%s]${RESET} %s\n" "$1" "$2"

}

pause() {
read -rp "$(printf "${GRAY}Press ENTER to continue...${RESET}")"
}

spinner() {

local pid=$!

local spin='⠋⠙⠸⠴⠦⠇'

local i=0

while kill -0 "$pid" 2>/dev/null
do
    i=$(( (i+1) %6 ))
    printf "\r${CYAN}%s${RESET}" "${spin:$i:1}"
    sleep 0.08
done

printf "\r \r"

}

run() {

local title="$1"

shift

info "$title"

"$@" &
spinner

success "Done"

}

ask() {

local question="$1"

printf "\n${YELLOW}?${RESET} %s " "$question"

read -r ans

echo "$ans"

}

yesno() {

while true
do

printf "${YELLOW}?${RESET} %s [Y/n] " "$1"

read -r yn

case "$yn" in

""|Y|y) return 0;;

N|n) return 1;;

esac

done

}

divider() {

printf "${GRAY}%s${RESET}\n" "$LINE"

}

finished() {

printf "\n"

divider

printf "${GREEN}${BOLD}"

cat << EOF

      ✔ Installation completed successfully

EOF

printf "${RESET}"

divider
logo() {
    banner
}

run_step() {

    local title="$1"
    local script="$2"

    section "$title"

    if [[ ! -f "$script" ]]; then
        error "Missing script: $script"
    fi

    if [[ ! -x "$script" ]]; then
        chmod +x "$script"
    fi

    info "Running $(basename "$script")"

    bash "$script"

    success "$title completed"
}
}
run_step() {
    local title="$1"
    local script="$2"

    section "$title"

    if [[ ! -f "$script" ]]; then
        error "Step not found: $script"
    fi

    if source "$script"; then
        success "$title completed"
    else
        error "$title failed"
    fi
}