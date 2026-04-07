#!/bin/bash

# Ruta al archivo donde guardas la IP del objetivo (estilo Parrot)
target_file="$HOME/.config/bin/target"

if [ -f "$target_file" ]; then
    ip_address=$(awk '{print $1}' "$target_file")
    machine_name=$(awk '{print $2}' "$target_file")

    if [ -n "$ip_address" ]; then
        echo "󰓾 $ip_address - $machine_name"
    else
        # Si el archivo está vacío, no mostrar nada o mostrar "No target"
        echo "󰓾 No target"
    fi
else
    echo "󰓾 No file"
fi
