-- ~/.config/nvim/lua/plugins/completion.lua
-- Autocompletado. blink.cmp es el motor moderno recomendado; reemplaza el
-- heredado `nvim-cmp` y trae LSP, snippets, path y buffer sources ya incluidas.
--
-- IMPORTANTE: pineamos `v1.4.1`. Las versiones más nuevas (>= v1.5) usan
-- `vim.lsp.config(...)` que sólo existe en Neovim 0.11+. Tu nvim es 0.10.4.
-- Cuando actualices a 0.11+, quita el `tag` y deja que use HEAD.

return {
  {
    "saghen/blink.cmp",
    tag = "v1.4.1",                        -- pin: API estable en Neovim 0.10
    event = "InsertEnter",                 -- cargar solo al entrar en insert
    dependencies = {
      -- Snippets: no instalamos por defecto (consérvalo simple).
      -- Si los necesitas: añade "L3MON4D3/LuaSnip" + "rafamadriz/friendly-snippets".
    },
    opts = {
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      -- Preset por defecto: `<Up>`/`<Down>`/`<C-n>`/`<C-p>` para navegar,
      -- `<C-y>` aceptar, `<C-e>` cancelar, `<Tab>` snippet_forward, etc.
      keymap = { preset = "default" },
      sources = {
        default = { "lsp", "path", "buffer" },
      },
    },
  },
}
