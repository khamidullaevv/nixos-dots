#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$SCRIPT_DIR/lib.sh"

section "Generating Configuration"

source "$SCRIPT_DIR/generators/configuration.sh"
source "$SCRIPT_DIR/generators/home.sh"
source "$SCRIPT_DIR/generators/hardware.sh"

generate_configuration
generate_home
generate_hardware

success "Configuration generated"