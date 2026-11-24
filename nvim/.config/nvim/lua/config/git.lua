local function git_terminal(command)
  if vim.fn.executable(command[1]) == 0 then
    vim.notify(command[1] .. " no está en el PATH", vim.log.levels.WARN)
    return
  end

  local root = vim.trim(vim.fn.system({ "git", "rev-parse", "--show-toplevel" }))
  if vim.v.shell_error ~= 0 then
    vim.notify("Abre Neovim desde un repositorio Git", vim.log.levels.WARN)
    return
  end

  local options = { cwd = root }
  if command[1] == "gh" then
    local user = vim.trim(vim.fn.system({ "git", "config", "--local", "--get", "credential.https://github.com.username" }))
    if vim.v.shell_error == 0 and user ~= "" then
      local token = vim.trim(vim.fn.system({ "gh", "auth", "token", "--hostname", "github.com", "--user", user }))
      if vim.v.shell_error ~= 0 or token == "" then
        vim.notify("Inicia sesión en GitHub CLI con la cuenta " .. user, vim.log.levels.WARN)
        return
      end
      options.env = { GH_TOKEN = token }
    end
  end

  vim.cmd.tabnew()
  vim.bo.bufhidden = "wipe"
  if vim.fn.termopen(command, options) <= 0 then
    vim.cmd.tabclose()
    vim.notify("No se pudo abrir " .. command[1], vim.log.levels.ERROR)
    return
  end
  vim.cmd.startinsert()
end

local function lazygit()
  local config = vim.fn.stdpath("config") .. "/lazygit.yml"
  local command = { "lazygit", "--use-config-file", config }
  if vim.fn.executable("lazygit") == 1 then
    local config_dir = vim.trim(vim.fn.system({ "lazygit", "--print-config-dir" }))
    local user_config = config_dir .. "/config.yml"
    if vim.v.shell_error == 0 and vim.fn.filereadable(user_config) == 1 then
      command[3] = config .. "," .. user_config
    end
  end
  git_terminal(command)
end

local pr_actions = {
  { label = "Crear borrador", command = { "gh", "pr", "create", "--draft" } },
  { label = "Ver PR de la rama", command = { "gh", "pr", "view" } },
  { label = "Revisar el diff del PR", command = { "gh", "pr", "diff" } },
  { label = "Consultar checks", command = { "gh", "pr", "checks" } },
  { label = "Abrir PR en el navegador", command = { "gh", "pr", "view", "--web" } },
}

local function pull_request()
  vim.ui.select(pr_actions, {
    prompt = "Pull request de GitHub",
    format_item = function(action) return action.label end,
  }, function(action)
    if action then
      git_terminal(action.command)
    end
  end)
end

vim.api.nvim_create_user_command("LazyGit", lazygit, {})
vim.api.nvim_create_user_command("GitPR", pull_request, {})
vim.keymap.set("n", "<leader>gg", lazygit, { desc = "Abrir Lazygit" })
vim.keymap.set("n", "<leader>gp", pull_request, { desc = "Acciones de pull request" })
