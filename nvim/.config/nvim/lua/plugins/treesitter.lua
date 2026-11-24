-- ~/.config/nvim/lua/plugins/treesitter.lua
if vim.fn.has("nvim-0.12") == 1 then
  return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  name = "nvim-treesitter-legacy",
  branch = "master",
  cmd = { "TSInstall", "TSInstallSync", "TSUpdate" },
}
