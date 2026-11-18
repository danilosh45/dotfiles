-- ~/.config/nvim/lua/plugins/whichkey.lua
-- Recordatorio de keybindings: cuando pulsas `s` y pausas, aparece un popup
-- con `sf`, `sg`, `sb`, `sr`, `sd`... así descubres tus propios atajos sin
-- tener que leer docstrings.

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = { spelling = true },    -- respeta spell-check en sugerencias
      })
      -- Registra explícitamente los prefijos `s` y `<leader>` para que el
      -- popup aparezca al pulsar la primera letra (en lugar de esperar al timeout).
      wk.add({
        { mode = { "n" }, prefix = "s",     group = "[s]earch/[s]plits" },
        { mode = { "n" }, prefix = "<leader>", group = "[Space] extras" },
      })
    end,
  },
}
