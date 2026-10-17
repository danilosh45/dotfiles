#!/usr/bin/env bash
#
# ~/dotfiles/scripts/bootstrap-gnome.sh
# Aplica la configuración GNOME gestionada por dotfiles:
#   1. Crea symlinks vía stow (config flameshot + binarios).
#   2. Carga dconf (keybindings).
#   3. Reinicia el portal xdg-desktop-portal si está disponible.
#

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
PKG="$DOTFILES_DIR/gnome"
DCONF_FILE="$DOTFILES_DIR/dconf-gnome/gnome.dconf"

echo "==> Stow gnome"
cd "$DOTFILES_DIR"
stow --restow --target="$HOME" gnome

echo "==> Cargar dconf"
if command -v dconf >/dev/null && [[ -f "$DCONF_FILE" ]]; then
  dconf load / < "$DCONF_FILE"
else
  echo "AVISO: dconf no disponible o falta $DCONF_FILE"
fi

echo "==> Reiniciar portal xdg-desktop-portal"
if systemctl --user status xdg-desktop-portal.service >/dev/null 2>&1; then
  systemctl --user restart xdg-desktop-portal.service || true
  systemctl --user restart xdg-desktop-portal-gnome.service || true
  echo "    Portal reiniciado"
else
  echo "    AVISO: xdg-desktop-portal no está en systemd, considera reiniciar la sesión"
fi

echo "==> Verificar symlinks clave"
for link in "$HOME/.local/bin/flameshot-screenshot.sh" \
            "$HOME/.config/flameshot" \
            "$HOME/.config/flameshot/flameshot.ini"; do
  if [[ -e "$link" ]]; then
    target="$(readlink -f "$link" 2>/dev/null || echo '?')"
    echo "    OK  $link -> $target"
  else
    echo "    FALTA $link"
  fi
done
chmod +x "$HOME/.local/bin/flameshot-screenshot.sh" || true

echo
echo "Listo. Atajos activos:"
echo "  <Super>Return           -> gnome-terminal"
echo "  <Shift><Super>s         -> flameshot-screenshot.sh (wrapper)"
echo "  <Super>r                -> gnome-screenshot (grabación)"
echo "  Print                   -> screenshot nativo GNOME"
echo "  <Shift>Print / <Alt>Pr  -> screenshot nativos GNOME"
echo
echo "Carpeta de guardado: \$HOME/Pictures/Screenshots"