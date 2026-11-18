-- ~/.config/nvim/lua/config/agents.lua
-- Integraciones con agentes de terminal. Se mantiene sin plugin para que
-- Codex pueda actualizarse de forma independiente de la configuración.

local function open_codex()
  if vim.fn.executable("codex") == 0 then
    vim.notify(
      "[nvim] No se encontró `codex` en PATH.",
      vim.log.levels.WARN
    )
    return
  end

  local cwd = vim.fn.getcwd()
  vim.cmd("botright 15split")

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)
  vim.bo[buf].bufhidden = "wipe"

  local job_id = vim.fn.termopen({ "codex" }, { cwd = cwd })
  if job_id <= 0 then
    vim.notify("[nvim] No se pudo iniciar Codex.", vim.log.levels.ERROR)
    return
  end

  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("Codex", open_codex, {})
vim.keymap.set("n", "<leader>ac", open_codex, {
  silent = true,
  noremap = true,
  desc = "Abrir Codex en split",
})
