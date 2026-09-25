#!/usr/bin/env bash
# Превращает вывод cava (ascii, 0-7) в блочные символы для waybar
bars=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)
cava -p "$HOME/.config/cava/config" | while IFS=';' read -ra vals; do
  out=""
  for v in "${vals[@]}"; do
    [ -z "$v" ] && continue
    out+="${bars[$v]}"
  done
  echo "$out"
done
