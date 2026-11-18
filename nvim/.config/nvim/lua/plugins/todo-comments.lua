-- ~/.config/nvim/lua/plugins/todo-comments.lua
-- Resalta TODO/FIXME/XXX/HACK en todos los archivos. Al pulsar `]t` y
-- `[t` saltas al siguiente / anterior. Muy útil cuando dejas comentarios
-- para ti en YAML/Playbooks.

return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = false,    -- no rompe la limpieza de la column signs (gitsigns la usa)
        keywords = {
          TODO = { color = "blue",  icon = "📌" },
          FIXME = { color = "yellow", icon = "🔧" },
          XXX   = { color = "red",   icon = "❌" },
          HACK  = { color = "orange", icon = "⚠️" },
        },
      })
    end,
  },
}
