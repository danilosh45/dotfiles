-- ~/.config/nvim/lua/config/lsp.lua
--
-- Configuración LSP cargada ANTES de lazy.nvim desde init.lua.
--
-- Dos razones para cargarla eager:
--   1. El PATH se añade tempranamente para que los binarios de Mason
--      (yamlls, terraform-ls, pyright, ...) sean visibles al invocarlos.
--      Sin esto, lspconfig intenta spawnear `yaml-language-server` y falla
--      con "not in PATH".
--   2. Los FileType autocmds de lspconfig.setup() quedan registrados
--      antes de que los plugins lleguen a lazy-load, evitando el race
--      condition en `nvim archivo.yml` desde CLI.

local function ensure_lspconfig_rtp()
  for _, p in ipairs(vim.api.nvim_list_runtime_paths()) do
    if p:match("nvim%-lspconfig") then return true end
  end
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig"
  if vim.fn.isdirectory(lazy_path) == 1 then
    vim.opt.rtp:append(lazy_path)
    return true
  end
  return false
end

if not ensure_lspconfig_rtp() then
  return
end

-- ── PATH: añade Mason bin al principio ────────────────────────────────────
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if vim.fn.isdirectory(mason_bin) == 1 then
  vim.env.PATH = mason_bin .. ":" .. (vim.env.PATH or "")
end

local ok_lc, lspconfig = pcall(require, "lspconfig")
if not ok_lc then return end

-- Servers a configurar (key corta lspconfig → binario Mason → mapping ft).
local servers = {
  yamlls      = { mason = "yaml-language-server",    fts = { "yaml", "yaml.*" } },
  -- ansiblels requiere interactive ansible-lint prompt; lo dejamos apagado
  -- y confiamos en yamlls + schemas YAML para Ansible.
  -- ansiblels = { mason = "ansible-language-server", fts = { "ansible" } },
  terraformls = { mason = "terraform-ls",            fts = { "terraform" } },
  dockerls    = { mason = "docker-language-server",  fts = { "dockerfile" } },
  pyright     = { mason = "pyright-langserver",      fts = { "python" } },
  bashls      = { mason = "bash-language-server",    fts = { "sh", "bash" } },
  jsonls      = { mason = "vscode-json-language-server", fts = { "json", "jsonc" } },
}

-- Keymaps por buffer (on_attach).
local lsp_on_attach = function(_client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- Schemas YAML (docker-compose, k8s, github actions).
local custom_yaml_schemas = {
  ["docker-compose.yml"]         = { "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" },
  ["docker-compose.*.yml"]       = { "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" },
  ["portainer.*.yml"]            = { "https://raw.githubusercontent.com/technonotes/portainer-stack-schema/main/schema.json" },
  ["*.k8s.yml"]                  = { "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/standalone-strict.json" },
  ["*.github/workflows/*.yml"]   = { "https://json.schemastore.org/github-workflow.json" },
  ["terraform.tfstate"]          = { "https://json.schemastore.org/terraform.json" },
}

local function build_settings(short_name)
  if short_name == "yamlls" then
    return {
      on_attach = lsp_on_attach,
      autostart = true,
      settings = {
        yaml = {
          schemas    = vim.tbl_deep_extend("force", custom_yaml_schemas, {}),
          validate   = true,
          completion = true,
          format     = { enable = true, singleQuote = false, indent = 2 },
        },
      },
    }
  end
  if short_name == "ansiblels" then
    -- ansible-language-server pide interactivamente ansible-lint si lo
    -- encuentra instalado. Lo desactivamos para evitar prompts.
    return {
      on_attach = lsp_on_attach,
      autostart = true,
      settings = {
        ansible = {
          ansible = { path = vim.fn.executable("ansible-lint") == 1 and "ansible-lint" or "" },
        },
      },
    }
  end
  return { on_attach = lsp_on_attach, autostart = true }
end

-- Handlers globales (signs).
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.diagnostic.on_publish_diagnostics

local signs = { Error = " ", Warn = " ", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  pcall(vim.fn.sign_define, "DiagnosticSign" .. type,
    { text = icon, texthl = "DiagnosticSign" .. type })
end

-- Setup de cada server. La primera vez que accedemos a `lspconfig[short]`,
-- el metatable de lspconfig hace lazy-load de `lspconfig.configs.<short>`.
-- (No necesitamos hacer require explícito antes de .setup().)
for short in pairs(servers) do
  pcall(function()
    -- esto dispara el lazy-load vía __index de lspconfig
    local _ = lspconfig[short]
    lspconfig[short].setup(build_settings(short))
  end)
end
