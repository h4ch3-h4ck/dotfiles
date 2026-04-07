#!/bin/bash
IFACE="tun0"
if ip link show "$IFACE" > /dev/null 2>&1; then
    IP=$(ip addr show "$IFACE" | awk '/inet / {print $2}' | cut -d/ -f1)
    echo "󰆧 $IP"
else
    echo "󰆧 Desc."
fi
