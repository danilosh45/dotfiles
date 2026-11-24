-- ~/.config/nvim/lua/plugins/colorscheme.lua
-- Solarized para Neovim con colores RGB de 24 bits.
-- Se carga antes que el resto de plugins para que todos puedan usar sus
-- grupos de resaltado.

return {
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.o.background = "dark"
      require("solarized").setup({})
      vim.cmd.colorscheme("solarized")
    end,
  },
}
