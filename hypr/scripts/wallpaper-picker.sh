#!/usr/bin/env bash

export PATH="/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH"

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

if [ ! -d "$WALLPAPER_DIR" ]; then
    WALLPAPER_DIR="$HOME/Downloads"
fi

cd "$WALLPAPER_DIR" || exit 1

# Получаем список изображений и видео
FILES=$(find . -maxdepth 1 -type f \
    \( -iname "*.mp4" -o -iname "*.mkv" \
    -o -iname "*.png" -o -iname "*.jpg" \
    -o -iname "*.jpeg" -o -iname "*.webp" \) \
    -printf "%f\n")

if [ -z "$FILES" ]; then
    notify-send "Ошибка" "Обои не найдены"
    exit 1
fi

# Выбор обоев
SELECTED=$(printf '%s\n' "$FILES" | \
    rofi -dmenu -i \
    -p "󰸉 Обои:" \
    -theme-str 'window {width: 40%;} listview {lines: 8;}')

if [ -z "$SELECTED" ]; then
    exit 0
fi

FULL_PATH="$WALLPAPER_DIR/$SELECTED"

# Сохраняем текущие обои
echo "$FULL_PATH" > "$HOME/.current_wallpaper"

echo "Wallpaper: $FULL_PATH"

# --------------------------------------------------
# MATUGEN
# --------------------------------------------------

echo "Running matugen..."

# Запускаем Matugen без интерактивного выбора цвета.
# Matugen сам анализирует изображение.
matugen image "$FULL_PATH" \
    -m dark \
    --type scheme-tonal-spot \
    --source-color-index 0

MATUGEN_EXIT=$?

echo "Matugen exit code: $MATUGEN_EXIT"

if [ "$MATUGEN_EXIT" -ne 0 ]; then
    notify-send "Ошибка Matugen" "Не удалось применить цветовую схему"
    exit 1
fi

# --------------------------------------------------
# WALLPAPER
# --------------------------------------------------

pkill mpvpaper 2>/dev/null

mpvpaper \
    -o "no-audio --loop-playlist --panscan=1.0" \
    '*' \
    "$FULL_PATH" \
    >/dev/null 2>&1 &

# --------------------------------------------------
# KITTY
# --------------------------------------------------

kill -SIGUSR1 "$(pgrep kitty)" 2>/dev/null

# --------------------------------------------------
# WAYBAR
# --------------------------------------------------

pkill waybar 2>/dev/null
sleep 0.2

waybar >/dev/null 2>&1 &

# --------------------------------------------------
# NOTIFICATION
# --------------------------------------------------

if command -v notify-send &>/dev/null; then
    notify-send "󰸉 Тема и обои обновлены" "$SELECTED"
fi
