#!/usr/bin/env bash

is_config_file="$HOME/.config/cava/config"
pipe="/tmp/cava.fifo"

# Если пайп уже существует — удаляем его, чтобы очистить зависшие буферы
if [ -p "$pipe" ]; then
    unlink "$pipe"
fi
mkfifo "$pipe"

# Убиваем старые зависшие процессы cava
pkill -f "cava -p $is_config_file"

# Запускаем CAVA в фоновом режиме
cava -p "$is_config_file" > /dev/null 2>&1 &

# При завершении скрипта (например, при killall waybar) убиваем cava и чистим fifo
trap 'pkill -f "cava -p $is_config_file"; rm -f "$pipe"' EXIT

# Таблица символов
dict=" ▂▃▄▅▆▇█"

# Читаем FIFO и выводим графику
while read -r line; do
    # Заменяем цифры 0-7 на символы эквалайзера
    output=""
    for (( i=0; i<${#line}; i++ )); do
        val="${line:$i:1}"
        if [[ "$val" =~ ^[0-7]$ ]]; then
            output+="${dict:$val:1}"
        else
            output+=" "
        fi
    done
    echo "$output"
done < "$pipe"
