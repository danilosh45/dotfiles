-- ~/.config/nvim/lua/config/options.lua
-- Opciones Vim/Neovim. Porte directo de vim/.vimrc para tener paridad total.

local opt = vim.opt

-- --- Edición básica ----------------------------------------------------------
opt.number = true                         -- 'set number'
opt.cursorline = true                     -- 'set cursorline'
opt.autoindent = true                     -- 'set autoindent'
opt.expandtab = true                      -- 'set expandtab'
opt.tabstop = 2                           -- 'set tabstop=2'
opt.shiftwidth = 2                        -- 'set shiftwidth=2'
opt.softtabstop = 2                       -- coherente con shiftwidth
opt.smartindent = true                    -- indent inteligente básico (no invasivo)

-- Backups: igual que en .vimrc (no ahora, no escribas, no swap)
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Búsqueda: hlsearch, ignorecase, smartcase (igual que .vimrc)
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true                       -- búsqueda incremental moderna
opt.showmode = false                       -- Neovim ya no muestra "--INSERT--"

-- Timeouts para mappings (igual que .vimrc)
opt.timeoutlen = 1000
opt.ttimeoutlen = 10

-- --- Interacción con terminal (responsivo en SSH y conexiones lentas) ------
-- Ten en cuenta que `timeoutlen=1000` con `ttimeoutlen=10` es la receta
-- clásica para que Esc sea instantáneo pero secuencias tipo `<leader>xx`
-- sigan funcionando.
opt.mouse = "a"                            -- ratón habilitado (no interfiere con atajos)
opt.clipboard = "unnamedplus"             -- copiar al portapapeles del sistema

-- --- Apariencia -------------------------------------------------------------
opt.termguicolors = true                   -- colores 24-bit si el terminal los soporta
opt.signcolumn = "yes"                     -- columna para git signs (gitsigns)
opt.numberwidth = 4
opt.relativenumber = false                 -- número absoluto (como en .vimrc)
opt.colorcolumn = "80,120"                 -- guías suaves en columnas anchas

-- --- Diagnóstico ------------------------------------------------------------
opt.shortmess:append("c")                  -- oculta mensajes "match X of Y" en completions

-- --- Configuración de split por defecto ------------------------------------
opt.splitbelow = true                      -- splits horizontales abajo
opt.splitright = true                      -- splits verticales a la derecha

-- --- Configuración de búsqueda grep ----------------------------------------
-- Telescope usa `rg` (ripgrep) por defecto; caer en `grep` si falta.
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep"
  vim.env.GREP_DEFAULT_OPTIONS = "--hidden --no-config"
end

-- --- Sin plugins extra por defecto. Lo que se quiera añadir va a plugins/ ----
