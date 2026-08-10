#!/usr/bin/env bash

export PATH="/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH"

CACHE_FILE="$HOME/.current_wallpaper"

if [ ! -f "$CACHE_FILE" ]; then
    DEFAULT_WALL=$(ls -1 $HOME/Pictures/Wallpapers/* 2>/dev/null | head -n 1)
    if [ -n "$DEFAULT_WALL" ]; then
        echo "$DEFAULT_WALL" > "$CACHE_FILE"
    else
        exit 0
    fi
fi

WALLPAPER=$(cat "$CACHE_FILE")

matugen image "$WALLPAPER" -m dark > /dev/null 2>&1

pkill mpvpaper 2>/dev/null
mpvpaper -o "no-audio --loop-playlist --panscan=1.0" '*' "$WALLPAPER" >/dev/null 2>&1 &

pkill waybar 2>/dev/null
waybar >/dev/null 2>&1 &
