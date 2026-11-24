-- ~/.config/nvim/lua/config/agents.lua
-- Integraciones con los agentes instalados en PATH.

local function open_agent(executable, name)
  if vim.fn.executable(executable) == 0 then
    vim.notify(
      ("[nvim] No se encontró `%s` en PATH."):format(executable),
      vim.log.levels.WARN
    )
    return
  end

  local cwd = vim.fn.getcwd()
  vim.cmd("botright 15split")

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)
  vim.bo[buf].bufhidden = "wipe"

  local job_id = vim.fn.termopen({ executable }, { cwd = cwd })
  if job_id <= 0 then
    vim.cmd.close()
    vim.notify(("[nvim] No se pudo iniciar %s."):format(name), vim.log.levels.ERROR)
    return
  end

  vim.cmd("startinsert")
end

local function register_agent(command, key, executable, name)
  local function open()
    open_agent(executable, name)
  end

  vim.api.nvim_create_user_command(command, open, {})
  vim.keymap.set("n", key, open, {
    silent = true,
    desc = "Abrir " .. name .. " en split",
  })
end

register_agent("Codex", "<leader>ac", "codex", "Codex")
register_agent("ClaudeCode", "<leader>aa", "claude", "Claude Code")
