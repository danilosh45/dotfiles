-- ~/.config/nvim/lua/plugins/colorscheme.lua
-- Colorscheme oficial de Solarized, de Ethan Schoonover.
-- Se carga antes que el resto de plugins para que todos puedan usar sus
-- grupos de resaltado.

return {
  {
    "altercation/vim-colors-solarized",
    lazy = false,
    priority = 1000,
    config = function()
      -- El tema oficial usa la paleta del terminal cuando Neovim se ejecuta
      -- dentro de una terminal. GNOME Terminal ya tiene configurados los 16
      -- colores base de Solarized, así que usamos ese modo.
      vim.g.solarized_termcolors = 16
      -- Solarized oficial define grupos cterm (no una paleta GUI completa).
      -- Así Neovim usa los colores del perfil de GNOME Terminal.
      vim.opt.termguicolors = false
      vim.o.background = "dark"
      vim.cmd.colorscheme("solarized")
    end,
  },
}
