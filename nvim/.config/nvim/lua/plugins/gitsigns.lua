-- ~/.config/nvim/lua/plugins/gitsigns.lua
-- Git inline: muestra +, ~, - en la línea según el cambio, y `]h`/`[h`
-- para saltar al siguiente/anterior hunk. Mucho más visual que el `git diff`
-- manual y menos invasivo que el `:Gitsigns diffthis` cada vez.

return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",                  -- cargar al leer un buffer (git repo)
    tag = "v0.9.0",                        -- pinea versión estable (HEAD rompe API)
    config = function()
      require("gitsigns").setup({
        -- Desactivar resaltado de números/línea y word-diff; mantener todo
        -- lo demás en default (signs, on_attach, etc.).
        numhl    = false,
        linehl   = false,
        word_diff = false,
      })
    end,
  },
}
