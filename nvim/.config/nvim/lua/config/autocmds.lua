-- ~/.config/nvim/lua/config/autocmds.lua
-- Autocmds globales. Porte directo del bloque cursor shape desde .vimrc, más
-- algunos autocmds nuevos para filetype-specific.

-- --- Cursor shape (DECSCUSR) -------------------------------------------------
-- I bloque en normal/visual, barra fina en insert, subrayado en replace.
-- (`:help 'guicursor'` para el formato completo.)
-- En Neovim sólo se necesita establecer `vim.opt.guicursor` (no requiere opts).
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Para terminales que sí interpretan las secuencias DECSCUSR (VTE/xterm/iTerm),
-- emitirlas al cambiar de modo y al salir de Neovim.
local function set_term_cursor_shape()
  local mode = vim.api.nvim_get_mode().mode
  if mode:find("i") then
    -- barra fina en insert (DECSCUSR 5)
    vim.cmd("silent !printf '\\e[5 q'")
  elseif mode:find("r") or mode:find("!") then
    -- subrayado en replace (DECSCUSR 3)
    vim.cmd("silent !printf '\\e[3 q'")
  elseif mode == "v" or mode:find("V") or mode:find("\22") then
    -- bloque en visual (DECSCUSR 1)
    vim.cmd("silent !printf '\\e[1 q'")
  else
    -- bloque sólido en normal (DECSCUSR 2)
    vim.cmd("silent !printf '\\e[2 q'")
  end
end

vim.api.nvim_create_autocmd({ "ModeChanged", "InsertEnter", "InsertLeave" }, {
  callback = function()
    -- Solo emitir si estamos en terminal real (no en GUI tipo Neovide).
    if vim.fn.has("gui_running") == 0 then
      set_term_cursor_shape()
    end
  end,
})

-- Reset al salir
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.cmd("silent !printf '\\e[0 q'")
  end,
})

-- --- File type --------------------------------------------------------------
-- Deshabilitar `matchpairs` en `*.tf` para no romper pares cuando aparecen
-- dentro de strings (Terraform).
vim.api.nvim_create_autocmd("FileType", {
  pattern = "terraform",
  callback = function()
    vim.opt_local.matchpairs = ""
  end,
})

-- Yaml/ansible: activar wrap suave para diffs largos y 2 espacios.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "yaml.*" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    -- Conformar al guardar (formatea con 2 espacios, consistente con ansible-lint).
    vim.opt_local.formatexpr = nil
  end,
})

-- Markdown: estilo ancho 80, sin autoindent raro.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "80"
  end,
})

-- Bash scripts: respetar shebang `#!/usr/bin/env bash` con 2 espacios.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
  end,
})
