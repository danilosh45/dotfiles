# `nvim/` — Módulo dotfiles para Neovim

Configuración Neovim **conservadora** que respeta atajos nativos de Vim y los
prefijos `s*` (sf, ss, sv, sh, sj, sk, sl, s?) ya usados en `vim/.vimrc`.

Pensada para sysadmin / IaC: YAML, Ansible, OpenTofu/Terraform, Docker,
Python (Ansible collections), Markdown, Bash.

## Requisitos

- `nvim >= 0.10` (Debian 13 / Ubuntu 24.04+).
- `git`, `curl` (para instalar lazy.nvim la primera vez).
- `ripgrep` (`apt install ripgrep`) — lo usa Telescope para grep.
- (Opcional) `lazygit`, `eza`, `bat` para integrar con Telescope.
- (Opcional) Node 18+ — algunos LSPs (`typescript-language-server`,
  `vscode-langservers-extracted`) lo requieren. **No es necesario para
  yamlls / terraformls / dockerls / pyright**, así que puedes saltar este paso.
- (Opcional) `build-essential` (gcc/cc) — para compiladores de treesitter
  en Neovim 0.10. Sin él, el resaltado funciona pero es más básico. Si
  falta, nvim avisa al arrancar con el comando exacto para instalarlo.

## Estructura

```
nvim/.config/nvim/
├── init.lua                 # entry point: carga plugins y mapeos
├── lua/
│   ├── config/
│   │   ├── options.lua      # opciones Vim/Neovim (portadas desde .vimrc)
│   │   ├── keymaps.lua      # <leader> = Space; prefijo s* preservado
│   │   ├── agents.lua       # Codex en split inferior
│   │   └── autocmds.lua     # cursor shape, ftplugins
│   └── plugins/
│       ├── colorscheme.lua  # Solarized oficial
│       ├── statusline.lua   # lualine con tema Solarized
│       ├── treesitter.lua   # yaml, terraform, dockerfile, markdown, etc.
│       ├── lsp.lua          # mason + lspconfig
│       ├── completion.lua   # blink.cmp
│       ├── telescope.lua    # find_files, grep, buffers
│       ├── gitsigns.lua     # git signs inline
│       ├── todo-comments.lua# resaltar TODO / FIXME / XXX
│       └── neo-tree.lua     # tree-explorer moderno (alternativa a :Explore)
└── README.md                # este archivo
```

## Bootstrap (primera vez)

```bash
cd ~/dotfiles
stow --restow --target="$HOME" nvim
nvim --headless '+Lazy! sync' +qa      # instala plugins
nvim                                  # abre y deja que Mason instale los LSPs
: Mason                               # (dentro de nvim) pulsar 'U' para todos
```

`codex` debe estar instalado y disponible en `PATH`. Dentro de Neovim puedes
abrirlo con `<Space>ac` o con `:Codex`; se inicia en un split inferior de 15
líneas usando el directorio de trabajo actual.

Tras eso, `nvim archivo.yml` abre con LSP yaml + treesitter + guardado
automático con conformación.

## Atajos principales

### Preservados desde `vim/.vimrc`

| Keymap | Acción                                  |
|--------|-----------------------------------------|
| `sf`   | File finder en la raíz Git del proyecto       |
| `sF`   | File finder amplio desde el cwd de Neovim     |
| `ss`   | Split horizontal                        |
| `sv`   | Split vertical                          |
| `sh/sj/sk/sl` | Mover foco entre splits         |
| `<Space>` | Saltar al siguiente split            |
| `+` / `-` | Increment / decrement número         |
| `<Tab>` / `<S-Tab>` | Siguiente / anterior tab   |
| `te`   | Abrir nueva tab                         |

### Nuevos (prefijo `s` + letra lógica, no chocan con los tuyos)

| Keymap | Acción                                          |
|--------|-------------------------------------------------|
| `sg`   | grep en la raíz Git del proyecto                |
| `sG`   | grep amplio desde el cwd de Neovim              |
| `sb`   | buffers abiertos                                |
| `s?`   | ayuda de keybindings (WhichKey)                 |
| `sr`   | rename del símbolo bajo el cursor (LSP)         |
| `sd`   | ir a definición (LSP)                           |
| `sD`   | ir a declaración (LSP)                          |
| `K`    | hover doc (LSP)                                 |
| `<leader>e` | toggle neo-tree (explorador de archivos)   |
| `<leader>gg` | abrir lazygit en split (si está instalado) |
| `<leader>ac` | abrir Codex en split inferior                  |
| `<C-s>` | guardar (compatible en modos normal e insert)   |

### Movimientos extra (sin prefijos ajenos)

| Keymap | Acción                                       |
|--------|----------------------------------------------|
| `H` / `L` | ir al inicio / fin del archivo           |
| `J`    | join lines (mantiene cursor en posición)     |

## Treesitter (resaltado avanzado de sintaxis)

Activado vía TS nativo de Neovim 0.10 + plugin `nvim-treesitter` pin v0.9.3
(para el comando `:TSInstallSync`). Los parsers se descargan la primera vez
que abres un archivo en el filetype correspondiente.

**Requisito:** `gcc/cc` (compilador C) — Lo trae `build-essential`:

```bash
sudo apt install -y build-essential
```

Si falta el compilador, nvim muestra un aviso al arrancar con el comando exacto
para instalarlo. Sin compilador, el resaltado funciona en modo regex (`syntax
on`, como Vim clásico) — funcional pero menos preciso.

Tras instalar gcc y abrir nvim por primera vez, los parsers se bajan en
background; al cabo de 1-2 minutos ya tendrás highlight avanzado en YAML,
Dockerfile, Terraform, Python, etc.



| Servidor        | Ficheros                         | Notas |
|-----------------|----------------------------------|-------|
| `yamlls`        | `*.yml`, `*.yaml` (Ansible, k8s, docker-compose) | Con schemas JSON para docker-compose, portainer, k8s, github actions. |
| `terraformls`   | `*.tf`, `*.tfvars`               | Sirve también para OpenTofu. Requiere `.git` o `.terraform/` para arrancar. |
| `dockerls`      | `Dockerfile`                     | Para `docker-compose.yml` se usa yamlls con su schema. |
| `pyright`       | `*.py` (Ansible collections)     | Type-checker de Python. |
| `bashls`        | `*.sh`, `*.bash`                 | |
| `jsonls`        | `*.json`, `*.jsonc`              | |

> **ansible-language-server (`ansiblels`)** está deshabilitado en
> `config/lsp.lua` porque al arrancar pide instalar `ansible-lint`
> interactivamente, lo que rompe sesiones headless. Si lo necesitas,
> instálalo desde Mason y descomenta su línea en `config/lsp.lua`.

## Cómo deshacer este módulo

```bash
cd ~/dotfiles
stow --delete nvim
rm -rf ~/.local/share/nvim
```
