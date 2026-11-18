#!/usr/bin/env bash
#
# ~/dotfiles/scripts/bootstrap-nvim.sh
# Aplica la configuración Neovim gestionada por dotfiles:
#   1. Stow del módulo nvim (crea symlinks en ~/.config/nvim).
#   2. Instala plugins vía lazy.nvim (lazy sync headless).
#   3. Instala los LSP servers vía Mason (:MasonInstall headless).
#
# Requisitos: nvim >= 0.10, git, curl.

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

echo "==> Stow nvim"
cd "$DOTFILES_DIR"
stow --restow --target="$HOME" nvim

echo "==> Sync plugins (lazy.nvim, headless)"
# `:Lazy! sync` corre en silencio. `+qa` cierra al terminar.
nvim --headless '+Lazy! sync' +qa 2>&1 | tail -20

echo "==> Install LSP servers (mason, headless)"
# Lista de servidores que declaramos en lua/plugins/lsp.lua y lua/config/lsp.lua.
# ansible-language-server queda desactivado en config/lsp.lua (pide
# ansible-lint de forma interactiva). Si lo quieres luego, instálalo
# con `:MasonInstall ansible-language-server` dentro de nvim.
LSP_LIST="yaml-language-server terraform-ls docker-language-server pyright bash-language-server json-lsp"
nvim --headless -c "MasonInstall ${LSP_LIST}" -c "sleep 90" +qa 2>&1 | tail -30

echo
echo "Listo. Atajos nuevos y conservados:"
echo "  sf            -> file finder (Telescope)"
echo "  sg            -> grep en proyecto"
echo "  sb            -> buffers abiertos"
echo "  sd            -> go to definition (LSP)"
echo "  sr            -> rename símbolo (LSP)"
echo "  K             -> hover doc (LSP)"
echo "  <C-s>         -> guardar (normal/insert/visual)"
echo "  ss/sv/sh/sj/sk/sl  -> splits"
echo "  sf/te/gT/gt   -> navegación (idem .vimrc)"
echo "  <Space>ac     -> abrir Codex en split inferior"
if command -v codex >/dev/null 2>&1; then
  echo "Codex detectado: $(codex --version 2>/dev/null | head -1)"
else
  echo "Aviso: codex no está en PATH; instala @openai/codex para usar <Space>ac."
fi
echo
echo "Abre nvim y ya tienes LSP activo en *.yml, *.tf, Dockerfile, *.py, *.sh..."
