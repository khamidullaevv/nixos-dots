#!/usr/bin/env bash

set -Eeuo pipefail

generate_home() {

    [[ -f "$STATE_DIR/config.env" ]] \
        || error "config.env not found."

    source "$STATE_DIR/config.env"

    local HOME_DIR="$ROOT_DIR/home/$USERNAME"

    ensure_dir "$HOME_DIR"

    render_template \
        "$TEMPLATE_DIR/default.nix.in" \
        "$HOME_DIR/default.nix"

    success "Home configuration generated"
    info "File: $HOME_DIR/default.nix"
}