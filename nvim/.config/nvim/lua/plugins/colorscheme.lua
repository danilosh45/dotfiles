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
      -- En Windows Terminal, usa la aproximación Solarized de 256 colores.
      -- GNOME Terminal ya tiene configurada la paleta ANSI de Solarized.
      local windows_terminal = (vim.env.WT_SESSION or "") ~= ""
        or (vim.env.WT_PROFILE_ID or "") ~= ""
      vim.g.solarized_termcolors = windows_terminal and 256 or 16
      vim.opt.termguicolors = false
      vim.o.background = "dark"
      vim.cmd.colorscheme("solarized")
    end,
  },
}
