#!/bin/bash

target_file="$HOME/.config/bin/target"

# 1. Comprobación ultra-rápida: si no existe o es tamaño 0, imprime y fuera.
if [[ ! -s "$target_file" ]]; then
    echo "󰓾 No target"
    exit 0
fi

# 2. Leemos el contenido. 
read -r ip_address machine_name < "$target_file"

# 3. Mostramos. Si machine_name está vacío, solo pondrá la IP.
echo "󰓾 ${ip_address}${machine_name:+ - $machine_name}"
