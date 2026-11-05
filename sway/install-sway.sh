#!/bin/bash
# Enlaza la config de Sway del repo en ~/.config (mismo patrón que install.sh).
# No toca Hyprland: ambos entornos conviven hasta que decidas quitar Hyprland.
# Waybar ya se enlaza completo desde install.sh (incluye config-sway y modules-sway.json).

set -e
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

make_link() {
    local src="$1" dst="$2"
    [[ -e "$src" ]] || { echo "[!] No existe: $src — saltando."; return; }
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        echo "[!] Backup: ${dst} → ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -sfn "$src" "$dst"
    echo "[✔] $dst"
}

# Config completa de Sway (config, config.d/, bin/, hypridle.conf)
make_link "$DOTFILES_DIR/sway" "$HOME/.config/sway"

# Portales: pantalla compartida por wlr
make_link "$DOTFILES_DIR/sway/xdg-desktop-portal/sway-portals.conf" \
          "$HOME/.config/xdg-desktop-portal/sway-portals.conf"

# Waybar: si ~/.config/waybar aún no es el symlink del repo, enlázalo
[[ -L "$HOME/.config/waybar" ]] || make_link "$DOTFILES_DIR/waybar" "$HOME/.config/waybar"

echo
echo "Paquetes necesarios (Arch):"
echo "  sudo pacman -S --needed sway swayidle xdg-desktop-portal-wlr xdg-desktop-portal-gtk \\"
echo "       grim slurp jq wl-clipboard libnotify polkit"
echo "  (waybar, swaync, rofi, ghostty, hyprlock, hypridle, hyprpolkitagent, brightnessctl,"
echo "   playerctl, wireplumber, nm-applet, blueman, bemoji ya los tienes)"
echo
echo "Validar:  sway --validate -c ~/.config/sway/config"
echo "Lanzar desde TTY:  ~/.config/sway/bin/sway-launch"
