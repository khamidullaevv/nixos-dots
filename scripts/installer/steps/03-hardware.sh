#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

STATE_DIR="$SCRIPT_DIR/state"
CONFIG_FILE="$STATE_DIR/config.env"
HARDWARE_FILE="$STATE_DIR/hardware.env"

mkdir -p "$STATE_DIR"

source "$SCRIPT_DIR/lib.sh"
source "$CONFIG_FILE"
# --------------------------------------------------
# CPU
# --------------------------------------------------

CPU_MODEL="$(lscpu | awk -F: '/Model name/ {print $2}' | xargs)"
CPU_VENDOR="$(lscpu | awk -F: '/Vendor ID/ {print $2}' | xargs)"

success "CPU              $CPU_MODEL"
success "CPU Vendor       $CPU_VENDOR"

# --------------------------------------------------
# Memory
# --------------------------------------------------

RAM_GB="$(awk '/MemTotal/ {printf "%.1f", $2/1024/1024}' /proc/meminfo)"

success "Memory           ${RAM_GB} GB"

# --------------------------------------------------
# GPU Detection
# --------------------------------------------------

GPU_COUNT=0

GPU_DATA=""

while IFS= read -r gpu
do
    model="$(echo "$gpu" | cut -d':' -f3- | xargs)"

    vendor="$(echo "$model" | awk '{print $1}')"

    success "GPU $((GPU_COUNT+1))            $model"

    GPU_DATA+="GPU${GPU_COUNT}_MODEL=\"$model\"\n"
    GPU_DATA+="GPU${GPU_COUNT}_VENDOR=\"$vendor\"\n"

    GPU_COUNT=$((GPU_COUNT+1))

done < <(lspci | grep -Ei "VGA|3D|Display")

success "GPU Count        $GPU_COUNT"

# --------------------------------------------------
# Firmware
# --------------------------------------------------

if [[ -d /sys/firmware/efi ]]; then
    FIRMWARE="UEFI"
else
    FIRMWARE="BIOS"
fi

success "Firmware         $FIRMWARE"

# --------------------------------------------------
# Vendor / Model
# --------------------------------------------------

VENDOR="$(cat /sys/devices/virtual/dmi/id/sys_vendor 2>/dev/null || echo Unknown)"
MODEL="$(cat /sys/devices/virtual/dmi/id/product_name 2>/dev/null || echo Unknown)"

success "Vendor           $VENDOR"
success "Model            $MODEL"

# --------------------------------------------------
# Device Type
# --------------------------------------------------

if ls /sys/class/power_supply/BAT* >/dev/null 2>&1
then
    DEVICE_TYPE="Laptop"
else
    DEVICE_TYPE="Desktop"
fi

success "Device           $DEVICE_TYPE"

# --------------------------------------------------
# Root Filesystem
# --------------------------------------------------

FILESYSTEM="$(findmnt -n -o FSTYPE /)"

success "Filesystem       $FILESYSTEM"

# --------------------------------------------------
# Disk Type
# --------------------------------------------------

ROOT_DISK="$(findmnt -n -o SOURCE / | sed 's/[0-9]*$//')"

if [[ "$ROOT_DISK" == *nvme* ]]; then
    DISK_TYPE="NVMe"
elif [[ "$ROOT_DISK" == *sd* ]]; then
    rotational="$(cat /sys/block/$(basename "$ROOT_DISK")/queue/rotational 2>/dev/null || echo 0)"

    if [[ "$rotational" == "1" ]]; then
        DISK_TYPE="HDD"
    else
        DISK_TYPE="SSD"
    fi
else
    DISK_TYPE="Unknown"
fi

success "Storage          $DISK_TYPE"

# --------------------------------------------------
# Save
# --------------------------------------------------

cat > "$HARDWARE_FILE" <<EOF
CPU_MODEL="$CPU_MODEL"
CPU_VENDOR="$CPU_VENDOR"

RAM_GB="$RAM_GB"

GPU_COUNT="$GPU_COUNT"
$(printf "%b" "$GPU_DATA")

FIRMWARE="$FIRMWARE"

DEVICE_TYPE="$DEVICE_TYPE"

VENDOR="$VENDOR"
MODEL="$MODEL"

FILESYSTEM="$FILESYSTEM"

DISK_TYPE="$DISK_TYPE"
EOF

echo

success "Hardware information saved"
info "File: $HARDWARE_FILE"