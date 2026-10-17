#!/usr/bin/env bash
#
# flameshot-screenshot.sh
# Wrapper de flameshot pensado para GNOME en Wayland.
#
# Por qué existe:
#   En GNOME + Wayland, invocar `flameshot gui` directamente desde un atajo
#   de GNOME suele fallar con "Error al guardar imagen" porque la GUI nativa
#   de Qt intenta usar el backend de portal de KDE/Gtk sin terminar de
#   negociar permisos. Este wrapper:
#     1. Asegura que la carpeta de destino exista.
#     2. Invoca `flameshot gui` con la ruta explícita y copia al clipboard.
#     3. Si flameshot falla, hace fallback a grim (Wayland puro) + wl-copy.
#
# Atajo recomendado en GNOME: <Shift><Super>s  ->  flameshot-screenshot.sh
#

set -euo pipefail

DEST_DIR="${FLAMESHOT_SCREENSHOT_DIR:-$HOME/Pictures/Screenshots}"
FILENAME="screenshot-$(date +%Y%m%d-%H%M%S).png"
DEST="$DEST_DIR/$FILENAME"

mkdir -p "$DEST_DIR"

# Intento 1: flameshot gui con ruta explícita + clipboard
if flameshot gui --path "$DEST_DIR" --filename "$FILENAME" --clipboard; then
  echo "OK $DEST" >&2
  exit 0
fi

# Fallback (Wayland): grim + slurp si están disponibles
if command -v grim >/dev/null && command -v slurp >/dev/null; then
  GEOMETRY="$(slurp 2>/dev/null || true)"
  if [[ -n "$GEOMETRY" ]]; then
    grim -g "$GEOMETRY" "$DEST"
    wl-copy < "$DEST" || true
    echo "FALLBACK $DEST" >&2
    exit 0
  fi
fi

echo "ERROR: no se pudo capturar la pantalla" >&2
exit 1