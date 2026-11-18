-- ~/.config/nvim/lua/plugins/neo-tree.lua
-- Explorador de archivos moderno (alternativa a :Explore de netrw).
-- NO es obligatorio: si prefieres seguir con `sf` (Telescope find_files)
-- ignora este plugin y no pasa nada.

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",                       -- solo se carga al invocar
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",      -- iconos (opcional)
    },
    config = function()
      local neo = require("neo-tree")
      neo.setup({
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,         -- muestra dotfiles (son parte de tu flujo)
            never_show = { "node_modules", ".git/objects" },
          },
        },
        window = {
          width = 30,
          mappings = {
            ["<leader>e"] = "close",       -- vuelve a cerrar el árbol
          },
        },
      })
    end,
  },
}
