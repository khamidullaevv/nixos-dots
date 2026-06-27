#!/usr/bin/env bash

GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
RESET="\033[0m"

run_step() {
    local title="$1"
    local script="$2"

    echo
    echo -e "${BLUE}==>${RESET} ${title}"

    bash "$script"

    echo -e "${GREEN}✔ Done${RESET}"
}