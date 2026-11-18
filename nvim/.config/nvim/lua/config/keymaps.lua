-- ~/.config/nvim/lua/config/keymaps.lua
-- Mapeos Neovim. Filosofía: respetar atajos nativos y los prefijos `s*` que ya
-- usas en vim/.vimrc. Lo nuevo también usa `s` como prefijo o `<leader>` (Space).

local map = vim.keymap.set
local opts = { silent = true, noremap = true }

-- Leader: Space (compatible con tu uso de <Space> como <C-w>w)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- --- KEYMAPS PRESERVADOS DE vim/.vimrc --------------------------------------

-- Guardar con Ctrl+Enter (de .vimrc). En terminal puede no llegar, así que
-- añadimos también <C-s> que sí llega en prácticamente cualquier terminal
-- moderno (incluido GNOME Terminal + Wayland).
map("n", "<C-Return>", "<Cmd>w<CR>", opts)
map({ "n", "i", "v" }, "<C-s>", "<Cmd>w<CR>", opts)

-- `sf` abre un file finder (antes era :Explore de netrw). Ahora invocamos
-- Telescope, que es la versión moderna y mucho más potente. Si por algún
-- motivo Telescope no carga aún, caemos a netrw.
map("n", "sf", function()
  local ok, _ = pcall(require, "telescope.builtin")
  if ok then
    require("telescope.builtin").find_files()
  else
    vim.cmd("Explore")
  end
end, opts)

-- Tabs / splits: iguales a .vimrc
map("n", "te", "<Cmd>tabedit<CR>", opts)
map("n", "<Tab>", "gt", opts)
map("n", "<S-Tab>", "gT", opts)
map("n", "sv", "<Cmd>vsplit<CR>", opts)
map("n", "ss", "<Cmd>split<CR>", opts)

-- Movimiento entre splits con s + flecha (igual a .vimrc)
map("n", "<Space>", "<C-w>w", opts)
map("n", "sh", "<C-w>h", opts)
map("n", "sk", "<C-w>k", opts)
map("n", "sj", "<C-w>j", opts)
map("n", "sl", "<C-w>l", opts)

-- Increment / decrement (como .vimrc)
map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

-- --- KEYMAPS NUEVOS (no chocan con los tuyos, siguen prefijo `s`) -----------

-- `sg`  → grep en proyecto (Telescope live_grep)
map("n", "sg", function()
  local ok, _ = pcall(require, "telescope.builtin")
  if ok then
    require("telescope.builtin").live_grep()
  else
    vim.cmd("vimgrep /")
  end
end, opts)

-- `sb`  → buffers abiertos (Telescope buffers)
map("n", "sb", function()
  local ok, _ = pcall(require, "telescope.builtin")
  if ok then
    require("telescope.builtin").buffers()
  else
    vim.cmd("bn")
  end
end, opts)

-- `s?`  → ayuda de keybindings (WhichKey, si está cargado)
map("n", "s?", "<Cmd>WhichKey<CR>", { silent = true })

-- `sr`  → rename del símbolo bajo el cursor (LSP)
map("n", "sr", "<Cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })

-- `sd`  → go to definition (LSP); cae en buscar palabra (:help h_g@)
--         si no hay servidor LSP para el buffer.
map("n", "sd", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    vim.lsp.buf.definition()
  else
    -- Fallback: saltar a la siguiente coincidencia de la palabra bajo el cursor
    vim.cmd("normal! *")
  end
end, { silent = true })

-- `K`   → hover doc (LSP)
map("n", "K", function()
  local ok, _ = pcall(vim.lsp.buf.hover)
  if not ok then
    -- Fallback nativo de Vim si no hay LSP
    vim.cmd("K")
  end
end, { silent = true })

-- `<leader>e`  → toggle neo-tree (explorador moderno de archivos)
map("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { silent = true })

-- `<leader>gg` → lazygit (si está instalado). No fuerza: si no existe,
-- no hace nada (`:silent which lazygit || echo '[lazygit no instalado]'`).
map("n", "<leader>gg", function()
  if vim.fn.executable("lazygit") == 1 then
    vim.cmd("split | terminal lazygit")
  else
    vim.notify("[lazygit no instalado — `apt install lazygit` o descarga de github.com/jesseduffield/lazygit]", vim.log.levels.WARN)
  end
end, { silent = true })

-- --- KEYMAPS DE MOVIMIENTO EXTRA (no chocan con nativos) ---------------------

-- `H` (al inicio de línea) se reemplaza por `g_`? No: en Vim nativo `H`
-- mueve el cursor a la primera línea visible (top of screen). Lo respetamos.
-- En cambio, añadimos `gh` y `gl` para ir a inicio/fin del archivo sin usar
-- `gg`/`G` (que ya tienen significado).
map("n", "<leader>0", "gg", opts)               -- <Space>0 = ir al inicio
map("n", "<leader>$", "G", opts)                -- <Space>$ = ir al final

-- `J` en Vim normal ya hace algo, no lo tocamos. `gJ` ya existe.

-- --- ATAJOS EN MODO INSERT (sin conflictos) ---------------------------------

-- `<C-s>` ya cubierto arriba (guardar). `<C-c>` es para salir de insert
-- rápidamente (como Esc pero más cómodo en teclado HHKB/Planck).

-- --- ATAJOS PARA ftplugin YAML/Ansible/Terraform ---------------------------
-- (Los ftplugin vivem en lua/config/autocmds.lua; el LSP on-attach mapea
--  K, <leader>ca, <leader>rn, gd, gr en buffers LSP, definido en plugins/lsp.lua.)
