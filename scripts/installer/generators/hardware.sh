#!/usr/bin/env bash

set -Eeuo pipefail

generate_hardware() {

    [[ -f "$STATE_DIR/config.env" ]] \
        || error "config.env not found."

    source "$STATE_DIR/config.env"

    local HOST_DIR="$ROOT_DIR/hosts/$HOSTNAME"

    ensure_dir "$HOST_DIR"

    info "Generating hardware-configuration.nix"

    sudo nixos-generate-config \
        --show-hardware-config \
        > "$HOST_DIR/hardware-configuration.nix"

    success "Hardware configuration generated"
    info "File: $HOST_DIR/hardware-configuration.nix"
}