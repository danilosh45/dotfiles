-- ~/.config/nvim/lua/plugins.lua
return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  {
  "craftzdog/solarized-osaka.nvim",
   lazy = false,
   priority = 1000,
   opts = {}
  },
  { "folke/neoconf.nvim", cmd = "Neoconf" },

  {
    "windwp/nvim-autopairs"
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons"}
  },
}

