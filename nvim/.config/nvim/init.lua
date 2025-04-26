-- ~/.config/nvim/init.lua
-- lazy vim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
-- end lazy setup

-- plugin setup for lazy 
require("lazy").setup("plugins")
-- Cargar plugins
if plugins then
    for _, plugin in ipairs(plugins) do
        if type(plugin) == "string" then
            require("lazy").plug(plugin)
        elseif type(plugin) == "table" then
            require("lazy").plug(plugin[1], plugin[2])
        end
    end
end

require("mason").setup()
require("mason-lspconfig").setup()

-- LSP configuration
local lspconfig = require('lspconfig')
-- function on_attach beferore use it 
local on_attach = function(client, bufnr)
  client.server_capabilities.signatureHelpProvider = false
end
-- language server config
-- lua
lspconfig.lua_ls.setup {}
-- yamls
lspconfig.yamlls.setup {}
-- c plus plus config
lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

vim.o.makeprg = "g++ -std=c++20 % -o %:r.out && ./%:r.out"

vim.cmd[[colorscheme solarized-osaka]]
-- Configuración básica de Neovim
vim.cmd("syntax on")
vim.cmd("set number")
vim.cmd("set cursorline")
vim.cmd("set autoindent")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set nobackup nowritebackup noswapfile")
vim.cmd("set hlsearch")
vim.cmd("set ignorecase smartcase")

-- lualine configuration
require "lualine-config"
-- Cargar mapeos
require("mappings")
require("autopairs")
