#!/usr/bin/env bash

export PATH="/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH"

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

if [ ! -d "$WALLPAPER_DIR" ]; then
    WALLPAPER_DIR="$HOME/Downloads"
fi

cd "$WALLPAPER_DIR" || exit 1

FILES=$(ls -1 | grep -E '\.(mp4|mkv|png|jpg|jpeg|webp)$')

if [ -z "$FILES" ]; then
    exit 1
fi

SELECTED=$(rofi -dmenu -i -p "󰸉 Обои:" -theme-str 'window {width: 40%;} listview {lines: 8;}' <<< "$FILES")

if [ -z "$SELECTED" ]; then
    exit 0
fi

FULL_PATH="$WALLPAPER_DIR/$SELECTED"

echo "$FULL_PATH" > "$HOME/.current_wallpaper"

matugen image "$FULL_PATH"

pkill mpvpaper 2>/dev/null
mpvpaper -o "no-audio --loop-playlist --panscan=1.0" '*' "$FULL_PATH" >/dev/null 2>&1 &

kill -SIGUSR1 $(pgrep kitty) 2>/dev/null
pkill waybar
sleep 0.2
waybar >/dev/null 2>&1 &

if command -v notify-send &> /dev/null; then
    notify-send "Тема и обои обновлены" "$SELECTED"
fi
#!/usr/bin/env bash

export PATH="/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH"

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

if [ ! -d "$WALLPAPER_DIR" ]; then
    WALLPAPER_DIR="$HOME/Downloads"
fi

cd "$WALLPAPER_DIR" || exit 1

FILES=$(ls -1 | grep -E '\.(mp4|mkv|png|jpg|jpeg|webp)$')

if [ -z "$FILES" ]; then
    exit 1
fi

SELECTED=$(rofi -dmenu -i -p "󰸉 Обои:" -theme-str 'window {width: 40%;} listview {lines: 8;}' <<< "$FILES")

if [ -z "$SELECTED" ]; then
    exit 0
fi

FULL_PATH="$WALLPAPER_DIR/$SELECTED"

# Сохраняем путь для автозагрузки
echo "$FULL_PATH" > "$HOME/.current_wallpaper"

# --- ИСПРАВЛЕННЫЙ ВЫЗОВ MATUGEN (Путь строго в конце) ---
matugen image -m dark --type scheme-tonal-spot "$FULL_PATH"

# Перезапуск сервисов и обоев
pkill mpvpaper 2>/dev/null
mpvpaper -o "no-audio --loop-playlist --panscan=1.0" '*' "$FULL_PATH" >/dev/null 2>&1 &

kill -SIGUSR1 $(pgrep kitty) 2>/dev/null
pkill waybar
sleep 0.2
waybar >/dev/null 2>&1 &

if command -v notify-send &> /dev/null; then
    notify-send "Тема и обои обновлены" "$SELECTED"
fi
