#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Проверяем демона awww
if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 0.5
fi

# Запуск wofi
CHOICE=$(ls "$WALLPAPER_DIR" | wofi --dmenu --prompt "󰸉 Выбери обои:" --width 400 --height 350 --cache-file /dev/null)

if [ -n "$CHOICE" ]; then
    awww img "$WALLPAPER_DIR/$CHOICE" \
        --transition-type "wipe" \
        --transition-angle 30 \
        --transition-step 90 \
        --transition-fps 60
fi
