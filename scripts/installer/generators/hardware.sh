#!/usr/bin/env bash

set -Eeuo pipefail

generate_hardware() {

    [[ -f "$STATE_DIR/config.env" ]] || error "config.env not found."

    source "$STATE_DIR/config.env"

    local HOST_DIR="$ROOT_DIR/hosts/$HOSTNAME"
    local OUTPUT="$OUTPUT_DIR/hardware"

    ensure_dir "$HOST_DIR"

    rm -rf "$OUTPUT"
    mkdir -p "$OUTPUT"

    info "Generating hardware configuration..."

    sudo nixos-generate-config \
        --show-hardware-config \
        > "$OUTPUT/hardware-configuration.nix"

    cp \
        "$OUTPUT/hardware-configuration.nix" \
        "$HOST_DIR/hardware-configuration.nix"

    success "Hardware configuration generated"
    info "File: $HOST_DIR/hardware-configuration.nix"
}