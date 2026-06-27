#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/lib.sh"

run_step "Checking system" "$SCRIPT_DIR/steps/01-check.sh"
run_step "User configuration" "$SCRIPT_DIR/steps/02-user.sh"
run_step "Hardware detection" "$SCRIPT_DIR/steps/03-hardware.sh"
run_step "Generating configuration" "$SCRIPT_DIR/steps/04-system.sh"
run_step "Building NixOS" "$SCRIPT_DIR/steps/05-build.sh"
run_step "Finish" "$SCRIPT_DIR/steps/99-finish.sh"