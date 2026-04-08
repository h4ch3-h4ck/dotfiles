#!/bin/bash
# ╔═══════════════════════════════════════════╗
# ║        h4ch3 dotfiles installer          ║
# ╚═══════════════════════════════════════════╝

set -e

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

ok()   { echo -e "${GREEN}[✔]${NC} $1"; }
info() { echo -e "${CYAN}[➜]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
err()  { echo -e "${RED}[✘]${NC} $1"; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "\n${BOLD}${CYAN}  h4ch3 dotfiles installer${NC}"
echo -e "  repo: ${DOTFILES_DIR}\n"

detect_gpu() {
    if lspci | grep -qi nvidia; then GPU="nvidia"
    elif lspci | grep -qi amd;    then GPU="amd"
    else                               GPU="intel"
    fi
    info "GPU detectada: ${BOLD}${GPU}${NC}"
}

make_link() {
    local src="$1" dst="$2"
    if [[ ! -e "$src" ]]; then
        warn "No existe en repo: $src — saltando."
        return
    fi
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        warn "Backup: ${dst} → ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    ok "  $(basename "$dst")"
}

create_symlinks() {
    info "Creando symlinks...\n"

    make_link "$DOTFILES_DIR/hypr"                        "$HOME/.config/hypr"
    make_link "$DOTFILES_DIR/waybar"                      "$HOME/.config/waybar"
    make_link "$DOTFILES_DIR/ghostty"                     "$HOME/.config/ghostty"
    make_link "$DOTFILES_DIR/starship/starship.toml"      "$HOME/.config/starship.toml"
    make_link "$DOTFILES_DIR/wofi"                        "$HOME/.config/wofi"
    make_link "$DOTFILES_DIR/zellij"                      "$HOME/.config/zellij"
    make_link "$DOTFILES_DIR/btop"                        "$HOME/.config/btop"
    make_link "$DOTFILES_DIR/kitty"                       "$HOME/.config/kitty"
    [[ -f "$DOTFILES_DIR/git/.gitconfig" ]] && \
        make_link "$DOTFILES_DIR/git/.gitconfig"          "$HOME/.gitconfig"
    [[ -f "$DOTFILES_DIR/zsh/zshrc.alias.linux" ]] && \
        make_link "$DOTFILES_DIR/zsh/zshrc.alias.linux"   "$HOME/.zsh_aliases"
    [[ -d "$DOTFILES_DIR/bin" ]] && \
        make_link "$DOTFILES_DIR/bin"                     "$HOME/.local/bin/dotfiles-bin"

    # macOS-only (ignorados): aerospace, iterm, cursor, vscode
    echo ""
    ok "Symlinks creados."
}

install_packages() {
    if [[ ! -f "$DOTFILES_DIR/pkglist.txt" ]]; then
        warn "pkglist.txt no encontrado — saltando."; return
    fi
    info "Instalando paquetes desde pkglist.txt..."
    sudo pacman -S --needed --noconfirm - < "$DOTFILES_DIR/pkglist.txt" || \
        warn "Algunos paquetes son AUR. Instálalos con: yay -S <paquete>"
    ok "Paquetes instalados."
}

apply_gpu_config() {
    if [[ "$GPU" == "nvidia" ]]; then
        info "Nvidia detectada — asegúrate de tener estas env vars en hyprland.conf:"
        echo -e "
    env = LIBVA_DRIVER_NAME,nvidia
    env = XDG_SESSION_TYPE,wayland
    env = GBM_BACKEND,nvidia-drm
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia
    env = WLR_NO_HARDWARE_CURSORS,1\n"
    else
        info "${GPU} detectada — no se requiere config extra de GPU."
    fi
}

set_zsh_default() {
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        info "Estableciendo zsh como shell por defecto..."
        chsh -s "$(which zsh)"
        ok "Shell cambiado a zsh. Reinicia sesión para aplicar."
    else
        ok "zsh ya es el shell por defecto."
    fi
}

main() {
    detect_gpu
    echo ""
    echo -e "${BOLD}¿Qué quieres instalar?${NC}"
    echo "  1) Todo (paquetes + symlinks)"
    echo "  2) Solo symlinks"
    echo "  3) Solo paquetes"
    read -rp "  Elige [1/2/3]: " choice
    echo ""

    case "$choice" in
        1) install_packages; create_symlinks; apply_gpu_config; set_zsh_default ;;
        2) create_symlinks; apply_gpu_config; set_zsh_default ;;
        3) install_packages ;;
        *) err "Opción inválida."; exit 1 ;;
    esac

    echo -e "${GREEN}${BOLD}\n  ¡Listo! Recarga Hyprland con: hyprctl reload${NC}\n"
}

main
