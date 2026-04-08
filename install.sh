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

# ── Detección de GPU ──────────────────────────
detect_gpu() {
    if lspci | grep -qi nvidia; then GPU="nvidia"
    elif lspci | grep -qi amd;    then GPU="amd"
    else                               GPU="intel"
    fi
    info "GPU detectada: ${BOLD}${GPU}${NC}"
}

# ── Crear symlink ─────────────────────────────
make_link() {
    local src="$1" dst="$2"
    if [[ ! -e "$src" ]]; then
        warn "No existe: $src — saltando."
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

# ── Symlinks ──────────────────────────────────
create_symlinks() {
    info "Creando symlinks...\n"

    # Hyprland (hyprland.conf + hyprlock.conf + hypridle.conf + wallust/)
    make_link "$DOTFILES_DIR/hypr/hyprland.conf"          "$HOME/.config/hypr/hyprland.conf"
    make_link "$DOTFILES_DIR/hypr/hyprlock.conf"          "$HOME/.config/hypr/hyprlock.conf"
    make_link "$DOTFILES_DIR/hypr/hypridle.conf"          "$HOME/.config/hypr/hypridle.conf"
    make_link "$DOTFILES_DIR/hypr/wallust"                "$HOME/.config/hypr/wallust"

    # Waybar
    make_link "$DOTFILES_DIR/waybar"                      "$HOME/.config/waybar"

    # Ghostty
    make_link "$DOTFILES_DIR/ghostty"                     "$HOME/.config/ghostty"

    # Starship
    make_link "$DOTFILES_DIR/starship/starship.toml"      "$HOME/.config/starship.toml"

    # Wofi
    make_link "$DOTFILES_DIR/wofi"                        "$HOME/.config/wofi"

    # btop
    make_link "$DOTFILES_DIR/btop"                        "$HOME/.config/btop"

    # Git
    make_link "$DOTFILES_DIR/git/gitconfig"               "$HOME/.gitconfig"

    # Zsh
    make_link "$DOTFILES_DIR/zsh/zshrc"                   "$HOME/.zshrc"
    make_link "$DOTFILES_DIR/zsh/zshrc.linux"             "$HOME/.zshrc.linux"
    make_link "$DOTFILES_DIR/zsh/zshrc.alias"             "$HOME/.zshrc.alias"
    make_link "$DOTFILES_DIR/zsh/zshrc.alias.linux"       "$HOME/.zshrc.alias.linux"

    echo ""
    ok "Symlinks creados."
}

# ── Instalar paquetes ─────────────────────────
install_packages() {
    if [[ ! -f "$DOTFILES_DIR/pkglist.txt" ]]; then
        warn "pkglist.txt no encontrado — saltando."; return
    fi
    info "Instalando paquetes desde pkglist.txt..."
    sudo pacman -S --needed --noconfirm - < "$DOTFILES_DIR/pkglist.txt" || \
        warn "Algunos paquetes son AUR. Instálalos con: yay -S <paquete>"
    ok "Paquetes instalados."
}

# ── Config según GPU ──────────────────────────
apply_gpu_config() {
    case "$GPU" in
        nvidia)
            warn "Nvidia detectada — asegúrate de tener estas env vars en hyprland.conf:"
            echo -e "
    env = LIBVA_DRIVER_NAME,nvidia
    env = XDG_SESSION_TYPE,wayland
    env = GBM_BACKEND,nvidia-drm
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia
    env = WLR_NO_HARDWARE_CURSORS,1\n"
            ;;
        amd|intel)
            ok "GPU ${GPU} — no se requiere config extra."
            ;;
    esac
}

# ── Zsh por defecto ───────────────────────────
set_zsh_default() {
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        info "Estableciendo zsh como shell por defecto..."
        chsh -s "$(which zsh)"
        ok "Shell cambiado a zsh. Reinicia sesión para aplicar."
    else
        ok "zsh ya es el shell por defecto."
    fi
}

# ── Oh-my-zsh ─────────────────────────────────
install_omz() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        info "Instalando oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        ok "oh-my-zsh instalado."
    else
        ok "oh-my-zsh ya está instalado."
    fi

    # Plugins
    local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
        ok "Plugin: zsh-autosuggestions"
    fi
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
        ok "Plugin: zsh-syntax-highlighting"
    fi
}

# ── Main ──────────────────────────────────────
main() {
    detect_gpu
    echo ""
    echo -e "${BOLD}¿Qué quieres instalar?${NC}"
    echo "  1) Todo (paquetes + symlinks + oh-my-zsh)"
    echo "  2) Solo symlinks"
    echo "  3) Solo paquetes"
    read -rp "  Elige [1/2/3]: " choice
    echo ""

    case "$choice" in
        1)
            install_packages
            install_omz
            create_symlinks
            apply_gpu_config
            set_zsh_default
            ;;
        2)
            create_symlinks
            apply_gpu_config
            set_zsh_default
            ;;
        3)
            install_packages
            ;;
        *)
            err "Opción inválida."; exit 1 ;;
    esac

    echo -e "${GREEN}${BOLD}\n  ¡Listo! Recarga Hyprland con: hyprctl reload${NC}\n"
}

main
