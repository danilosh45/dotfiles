-- ~/.config/nvim/lua/mappings.lua

local map = vim.api.nvim_set_keymap

-- Guarda con Ctrl+Enter
map('n', '<C-Return>', ':w<CR>', { noremap = true, silent = true })

-- Abrir el explorador de archivos con sf netrew
map('n', 'sf', ':Explore<CR>', { noremap = true, silent = true })

-- Incrementa y decrementa con las teclas - +
map('n', '+', '<C-a>', { noremap = true, silent = true })
map('n', '-', '<C-x>', { noremap = true, silent = true })

-- Manejo de tabs y ventanas
map('n', 'te', ':tabedit<CR>', { noremap = true, silent = true })
map('n', '<Tab>', 'gt', { noremap = true, silent = true })
map('n', '<S-Tab>', 'gT', { noremap = true, silent = true })
map('n', 'sv', ':vsplit<CR>', { noremap = true, silent = true })
map('n', 'ss', ':split<CR>', { noremap = true, silent = true })

-- Moverse entre buffers cuando hago split tanto vertical como horizontal
vim.api.nvim_set_keymap('n', '<Space>', '<C-w>w', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sh', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sk', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sj', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sl', '<C-w>l', { noremap = true, silent = true })

-- En el explorador de archivos, crea un nuevo archivo con 'N'
vim.cmd("autocmd FileType netrw nmap <buffer> N :call inputsave()\\|let name = input('Enter file name: ')\\|call inputrestore()\\|execute 'e %:h/' . name<CR>")

