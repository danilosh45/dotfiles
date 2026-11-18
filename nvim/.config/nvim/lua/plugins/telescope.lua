-- ~/.config/nvim/lua/plugins/telescope.lua
-- File finder (sf), grep (sg), buffers (sb). Más rápido que el :Explore
-- de netrw y con soporte de ripgrep.
--
-- Pinea a `v0.2.2`: última estable con API compatible con Neovim 0.10.

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.2",
    cmd = "Telescope",                    -- solo se carga al invocar comandos
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      local action = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-j>"]     = action.move_selection_next,
              ["<C-k>"]     = action.move_selection_previous,
              ["<Down>"]    = action.move_selection_next,
              ["<Up>"]      = action.move_selection_previous,
              ["<C-h>"]     = action.preview_scrolling_left,
              ["<C-l>"]     = action.preview_scrolling_right,
              ["<Esc>"]     = action.close,
              ["<C-c>"]     = action.close,
              ["<CR>"]      = action.select_default,
            },
          },
        },
        pickers = {
          -- Telescope usa ripgrep por defecto. Si no está instalado, cae
          -- automáticamente a `find`. No hace falta configurar manualmente.
          find_files = {
            -- Excluir caches y dotfiles pesados por defecto. (Cuando rg está
            -- en PATH; si no, telescope ignora estos flags silenciosamente.)
            find_command = (function()
              if vim.fn.executable("rg") == 1 then
                return {
                  "rg", "--files", "--hidden", "--no-config",
                  "--glob", "!.git/*",
                  "--glob", "!node_modules/*",
                  "--glob", "!vendor/*",
                  "--glob", "!.venv/*",
                }
              end
              return nil  -- deja que telescope use `find`
            end)(),
          },
        },
      })
    end,
  },
}
