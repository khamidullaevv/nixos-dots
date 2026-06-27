#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/lib.sh"

banner

run_step "Checking Environment" "$SCRIPT_DIR/steps/01-check.sh"
run_step "User Configuration" "$SCRIPT_DIR/steps/02-user.sh"
run_step "Hardware Detection" "$SCRIPT_DIR/steps/03-hardware.sh"
run_step "Generating Configuration" "$SCRIPT_DIR/steps/04-system.sh"
run_step "Building System" "$SCRIPT_DIR/steps/05-build.sh"
run_step "Finishing Installation" "$SCRIPT_DIR/steps/99-finish.sh"

echo
success "Installation completed successfully."