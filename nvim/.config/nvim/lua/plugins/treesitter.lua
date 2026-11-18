-- ~/.config/nvim/lua/plugins/treesitter.lua
-- Usamos `nvim-treesitter` pin v0.9.3 (último estable con `:TSInstall`
-- robusto, compatible con Neovim 0.10). Su única misión aquí es descargar
-- y compilar los parsers. NO tocamos su API ni usamos su config moderna
-- (que cambia entre versiones). Solo lo cargamos para su comando `:TSInstall`.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.3",
    -- Sólo cargar el módulo cuando el usuario escribe `:TSInstall` o
    -- necesitamos acceso al binario. Sin config() automático.
    cmd = { "TSInstall", "TSInstallSync", "TSUpdate" },
    -- NO especificamos `main` ni `config`, así no rompe cosas al cargar.
  },
}
