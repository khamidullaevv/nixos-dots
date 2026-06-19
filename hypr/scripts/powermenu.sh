#!/usr/bin/env bash

# Опции меню с красивыми иконками
lock="󰌾  Блокировка экрана"
logout="󰍃  Выйти из системы"
reboot="󰜉  Перезагрузка"
shutdown="󰐥  Выключение"

options="$lock\n$logout\n$reboot\n$shutdown"

# Параметры wofi: 
# --location 0 (по центру)
# --style (подключаем наш CSS)
# --no-actions (убирает лишний мусор)
# --hide-scroll (прячет полосу прокрутки)
choice=$(echo -e "$options" | wofi --dmenu \
    --prompt "Куда направляемся?" \
    --conf /dev/null \
    --style ~/.config/hypr/scripts/powermenu.css \
    --width 400 \
    --height 280 \
    --location 0 \
    --hide-scroll \
    --no-actions)

case $choice in
    "$lock")
        hyprlock
        ;;
    "$logout")
        hyprctl dispatch exit 0
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
esac
