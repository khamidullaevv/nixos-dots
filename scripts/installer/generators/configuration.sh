#!/usr/bin/env bash

set -Eeuo pipefail

generate_configuration() {

    [[ -f "$STATE_DIR/config.env" ]] \
        || error "config.env not found."

    source "$STATE_DIR/config.env"

    local HOST_DIR="$ROOT_DIR/hosts/$HOSTNAME"

    ensure_dir "$HOST_DIR"

    render_template \
        "$TEMPLATE_DIR/configuration.nix.in" \
        "$HOST_DIR/configuration.nix"

    success "Configuration generated"
    info "File: $HOST_DIR/configuration.nix"
}