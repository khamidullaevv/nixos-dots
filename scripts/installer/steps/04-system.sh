#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$SCRIPT_DIR/lib.sh"
source "$GENERATOR_DIR/configuration.sh"
source "$GENERATOR_DIR/home.sh"
source "$GENERATOR_DIR/hardware.sh"

generate_configuration
generate_home
generate_hardware