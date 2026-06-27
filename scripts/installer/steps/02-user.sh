#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

STATE_DIR="$SCRIPT_DIR/state"

CONFIG_FILE="$STATE_DIR/config.env"

mkdir -p "$STATE_DIR"

source "$SCRIPT_DIR/lib.sh"

echo

info "Let's configure your system."

echo

info "Let's configure your system."

echo

# --------------------------------------------------
# Username
# --------------------------------------------------

while true; do
    read -rp "Username: " USERNAME

    if [[ "$USERNAME" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
        break
    fi

    warning "Username may contain only lowercase letters, numbers, '-' and '_'."
done

# --------------------------------------------------
# Hostname
# --------------------------------------------------

while true; do
    read -rp "Hostname: " HOSTNAME

    if [[ "$HOSTNAME" =~ ^[a-zA-Z0-9-]+$ ]]; then
        break
    fi

    warning "Invalid hostname."
done

# --------------------------------------------------
# Timezone
# --------------------------------------------------

read -rp "Timezone [Asia/Tashkent]: " TIMEZONE
TIMEZONE="${TIMEZONE:-Asia/Tashkent}"

# --------------------------------------------------
# Locale
# --------------------------------------------------

read -rp "Locale [en_US.UTF-8]: " LOCALE
LOCALE="${LOCALE:-en_US.UTF-8}"

# --------------------------------------------------
# Shell
# --------------------------------------------------

echo
echo "Choose your shell:"
echo "  1) fish"
echo "  2) bash"
echo "  3) zsh"
echo

read -rp "Selection [1]: " CHOICE

case "$CHOICE" in
    2)
        SHELL="bash"
        ;;
    3)
        SHELL="zsh"
        ;;
    *)
        SHELL="fish"
        ;;
esac

# --------------------------------------------------
# Save
# --------------------------------------------------

cat > "$CONFIG_FILE" <<EOF
USERNAME="$USERNAME"
HOSTNAME="$HOSTNAME"
TIMEZONE="$TIMEZONE"
LOCALE="$LOCALE"
SHELL="$SHELL"
EOF

echo

success "Configuration saved"

info "File: $CONFIG_FILE"