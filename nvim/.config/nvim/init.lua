-- ~/.config/nvim/init.lua
-- Punto de entrada Neovim. Filosofía:
--   - Conservador: respeta atajos nativos Vim + prefijo `s*` heredado.
--   - Modular: cada aspecto (tema, LSP, completion, telescope...) está
--     en lua/plugins/*.lua y se carga de forma lazy por lazy.nvim.
--   - En servidor sin nvim moderno: `vi` o `vim` (siguen en PATH).

-- 1) Bootstrap lazy.nvim (plugin manager) -------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2) Config base (portada desde .vimrc; ligera) ------------------------------
require("config.options")
require("config.keymaps")
require("config.agents")
require("config.autocmds")
require("config.treesitter")  -- activación TS nativo (descarga parsers si faltan)
require("config.lsp")        -- LSP eager (necesario para que PATH y autocmds estén listos)

-- 3) Cargar plugins declarados en lua/plugins/*.lua (lazy) --------------------
require("lazy").setup("plugins", {
  -- Opciones globales de lazy.nvim
  change_detection = { enabled = false },  -- no escanea el filesystem (rápido)
  install      = { missing = false },     -- no instalar de inicio, solo bajo demanda
  checker      = { enabled = false },     -- sin avisos de actualización en cada save
  performance  = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
