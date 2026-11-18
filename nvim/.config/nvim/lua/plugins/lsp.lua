-- ~/.config/nvim/lua/plugins/lsp.lua
-- La config real del LSP está en `lua/config/lsp.lua` (cargada eagerly
-- desde init.lua, ANTES de lazy). Aquí sólo declaramos los plugins que
-- lazy debe descargar.

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "yamlls", "terraformls", "dockerls",
          "pyright", "bashls", "jsonls",
        },
        automatic_installation = false,
        automatic_enable       = false,
      })
    end,
  },
  -- nvim-lspconfig: plugin base para lspconfig.<server>.setup().
  -- Su carga eager real ocurre en config/lsp.lua para evitar el race condition
  -- del FileType al abrir archivos desde CLI.
  {
    "neovim/nvim-lspconfig",
    tag = "v1.8.0",
    lazy = false,
  },
}
