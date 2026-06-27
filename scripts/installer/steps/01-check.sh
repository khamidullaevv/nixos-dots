#!/usr/bin/env bash

set -e

echo

# --------------------------------------------------
# Operating System
# --------------------------------------------------

if [[ -f /etc/NIXOS ]]; then
    success "Operating System      NixOS"
else
    error "This installer only supports NixOS."
fi

# --------------------------------------------------
# Architecture
# --------------------------------------------------

ARCH="$(uname -m)"

if [[ "$ARCH" == "x86_64" ]]; then
    success "Architecture          $ARCH"
else
    error "Unsupported architecture: $ARCH"
fi

# --------------------------------------------------
# Internet
# --------------------------------------------------

if ping -c1 1.1.1.1 >/dev/null 2>&1; then
    success "Internet Connection"
else
    error "No Internet connection."
fi

# --------------------------------------------------
# Git
# --------------------------------------------------

if command -v git >/dev/null; then
    success "Git"
else
    error "Git is not installed."
fi

# --------------------------------------------------
# Nix
# --------------------------------------------------

if command -v nix >/dev/null; then
    success "Nix"
else
    error "Nix is missing."
fi

# --------------------------------------------------
# Flakes
# --------------------------------------------------

if nix flake metadata >/dev/null 2>&1; then
    success "Flakes"
else
    error "Flakes are not enabled."
fi

# --------------------------------------------------
# Git Repository
# --------------------------------------------------

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    success "Git Repository"
else
    error "Run installer inside repository."
fi

# --------------------------------------------------
# sudo
# --------------------------------------------------

if sudo -n true 2>/dev/null; then
    success "Sudo Access"
else
    warning "Sudo password will be required later."
fi

# --------------------------------------------------
# UEFI
# --------------------------------------------------

if [[ -d /sys/firmware/efi ]]; then
    success "UEFI Boot"
else
    warning "Legacy BIOS detected."
fi

# --------------------------------------------------
# Disk
# --------------------------------------------------

FREE=$(df / --output=avail | tail -1)

if (( FREE > 5000000 )); then
    success "Disk Space"
else
    warning "Less than 5 GB free."
fi

echo