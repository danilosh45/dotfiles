-- ~/.config/nvim/lua/config/treesitter.lua
-- Treesitter: descarga parsers en el primer arranque y activa highlight.
--
-- En Neovim 0.10/0.11 se conserva el instalador de la rama master.

local parsers = {
  "yaml",
  "lua",
  "bash",
  "markdown", "markdown_inline",
  "json",
  "dockerfile",
  "terraform",
  "python",
  "toml",
  "html",
  "css",
}

if vim.fn.has("nvim-0.12") == 1 then
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(event)
      local lang = vim.treesitter.language.get_lang(event.match)
      if vim.tbl_contains(parsers, lang) and vim.treesitter.language.add(lang) then
        vim.treesitter.start(event.buf, lang)
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
      local ok, treesitter = pcall(require, "nvim-treesitter")
      if ok and vim.fn.executable("tree-sitter") == 1 and vim.fn.executable("cc") == 1 then
        treesitter.install(parsers)
      end
    end,
  })
  return
end

-- Mapa de nombre Neovim → nombre para `:TSInstall` (algunos difieren).
local parser_aliases = {
  yaml      = "yaml",
  lua       = "lua",
  bash      = "bash",
  markdown  = "markdown",
  markdown_inline = "markdown_inline",
  json      = "json",
  dockerfile = "dockerfile",
  terraform = "terraform",
  python    = "python",
  toml      = "toml",
  html      = "html",
  css       = "css",
}

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Sólo descargar si NO existe ya `:TSInstallSync` (plugin cargado).
    vim.defer_fn(function()
      -- Comprobar si el plugin `nvim-treesitter` está listo. Si no,
      -- silencio: el plugin es lazy (cmd-triggered) y se carga al primer
      -- `:TSInstallSync`. No mostramos warning al usuario.
      pcall(function() require("nvim-treesitter") end)

      if vim.fn.exists(":TSInstallSync") == 0 then
        -- Plugin no se ha cargado todavía. El primer `:TSInstallSync` lo
        -- activará automáticamente vía cmd de lazy.nvim. No spameamos
        -- warnings al usuario.
        return
      end

      -- Comprobar si gcc está disponible. Si no, no podemos compilar parsers.
      if vim.fn.executable("cc") == 0 and
         vim.fn.executable("gcc") == 0 and
         vim.fn.executable("clang") == 0 and
         vim.fn.executable("zig") == 0 then
        -- Mensaje claro y accionable SOLO si el usuario intentó instalar parsers
        -- o está abriendo un buffer con un filetype que requiere parser
        -- (en el primer arranque lo normal es que no avise).
        local dotfiles_msg = vim.fn.glob(vim.env.HOME .. "/.dotfiles_treesitter_ok") or ""
        if dotfiles_msg == "" then
          -- Echo directo en :messages (NO bloquea UI): "Press ENTER" no aparece.
          local lines = {
            "[nvim] Treesitter: gcc/cc no encontrado. Resaltado básico (syntax on).",
            "Para resaltado moderno: `sudo apt install build-essential`",
            "y luego en nvim: `:TSInstallSync yaml lua bash json dockerfile terraform python`",
          }
          for _, line in ipairs(lines) do
            vim.api.nvim_echo({{ line, "WarningMsg" }}, false, {})
          end
        end
        return
      end

      -- Comprobar si falta algún parser.
      local missing = {}
      for _, lang in ipairs(parsers) do
        if not pcall(vim.treesitter.language.add, lang) then
          table.insert(missing, lang)
        end
      end

      if #missing > 0 then
        local names = vim.tbl_map(function(l) return parser_aliases[l] or l end, missing)
        local list = table.concat(names, " ")
        vim.notify(
          "[nvim] Instalando parsers de treesitter: " .. list,
          vim.log.levels.INFO
        )
        -- Ejecutar instalación en background (no bloquea el inicio de nvim)
        vim.schedule(function()
          pcall(vim.cmd, "silent! TSInstallSync " .. list)
        end)
      end
    end, 100)
  end,
})
