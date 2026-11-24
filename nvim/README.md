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
- Para los LSP instalados por Mason, Node.js 22.13 o posterior y npm para
  YAML, JSON, Dockerfile, Bash y Pyright. Terraform usa un binario propio.
- Para compilar parsers de Tree-sitter, instala `build-essential` o un
  compilador de C equivalente. Neovim 0.12 requiere también el ejecutable
  `tree-sitter` 0.26.1 o posterior en el `PATH`.

## Estructura

```
nvim/.config/nvim/
├── init.lua                 # entry point: carga plugins y mapeos
├── lua/
│   ├── config/
│   │   ├── options.lua      # opciones Vim/Neovim (portadas desde .vimrc)
│   │   ├── keymaps.lua      # <leader> = Space; prefijo s* preservado
│   │   ├── agents.lua       # Codex y Claude Code en split inferior
│   │   └── autocmds.lua     # cursor shape, ftplugins
│   └── plugins/
│       ├── colorscheme.lua  # Solarized Dark en RGB
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
nvim
```

Tras eso, `nvim archivo.yml` abre con LSP yaml + treesitter + guardado
automático con conformación.

## Solarized y agentes

Neovim usa Solarized Dark en RGB de 24 bits en Windows Terminal (incluido
WSL) y GNOME Terminal. Los colores del editor son independientes de la
paleta ANSI del perfil. Si actualizas desde el tema anterior, ejecuta
`:Lazy install solarized.nvim` y vuelve a abrir Neovim.

`:Codex` y `:ClaudeCode` abren un split inferior de 15 líneas en el
directorio de trabajo actual. Instala `codex` y `claude` según los agentes
que uses y asegúrate de que sus ejecutables estén en el `PATH` de Neovim.
En WSL, usa el `PATH` de tu distribución Linux.

## Atajos principales

### Preservados desde `vim/.vimrc`

| Keymap | Acción                                  |
|--------|-----------------------------------------|
| `sf`   | File finder (Telescope; antes era `:Explore`) |
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
| `sg`   | grep en el proyecto (Telescope live grep)       |
| `sb`   | buffers abiertos                                |
| `s?`   | ayuda de keybindings (WhichKey)                 |
| `sr`   | rename del símbolo bajo el cursor (LSP)         |
| `sd`   | ir a definición (LSP)                           |
| `sD`   | ir a declaración (LSP)                          |
| `K`    | hover doc (LSP)                                 |
| `<leader>e` | toggle neo-tree (explorador de archivos)   |
| `<leader>gg` | abrir Lazygit en una pestaña (`:LazyGit`) |
| `<leader>gp` | crear o revisar el PR de GitHub (`:GitPR`) |
| `<leader>yf` | copiar la ruta Git y la línea o selección |
| `<leader>ac` | abrir Codex en split inferior                  |
| `<leader>aa` | abrir Claude Code en split inferior            |
| `<C-s>` | guardar (compatible en modos normal e insert)   |

### Movimientos extra (sin prefijos ajenos)

| Keymap | Acción                                       |
|--------|----------------------------------------------|
| `H` / `L` | ir al inicio / fin del archivo           |
| `J`    | join lines (mantiene cursor en posición)     |

## Git desde Neovim

Consulta la [guía de Git con Lazygit](WORKFLOW-GIT.md) para ver los atajos,
el staging por bloques y el recorrido completo hasta el PR.

Instala `lazygit` y `gh` y asegúrate de que estén en el `PATH`.
En un repositorio personal puedes configurar la autoría local con
`git config --local user.name USUARIO` y `git config --local user.email CORREO`.
`git var GIT_AUTHOR_IDENT` muestra el autor que usará el próximo commit.
La identidad de los commits y la cuenta que autentica el push se configuran
por separado. En GitHub, comprueba la cuenta activa con `gh auth status`.

1. Actualiza la rama base y crea tu rama. Por ejemplo, desde `main` al día,
   `git switch -c fix/nvim-completion`.
2. En Neovim pulsa `Space g g`. Revisa el diff en **Files** y usa `Space`
   para preparar los archivos. Con `Enter` puedes entrar al diff y preparar
   solo los bloques que correspondan al cambio.
3. En **Files**, pulsa `Ctrl-v` para elegir el tipo y escribir el ámbito,
   el resumen y, si aporta contexto, el motivo. Por ejemplo,
   `fix(nvim): corrige el autocompletado en Telescope`. Revisa el título
   antes de confirmar.
4. Pulsa `P` en Lazygit para subir tu rama. La primera vez también puedes
   usar `git push -u origin HEAD`.
5. En Neovim pulsa `Space g p` y elige **Crear borrador**. Comprueba la
   rama base y explica qué cambia y cómo lo probaste. En el mismo menú
   puedes revisar el diff y los checks.
6. Cuando el PR esté listo, márcalo como preparado para revisión desde
   GitHub o con `gh pr ready`. Haz el merge desde GitHub tras las revisiones
   y los checks requeridos. GitLab llama *merge request* a este flujo y usa
   `glab mr create` para abrir uno.

## Tareas con Obsidian y agentes

Usa [la plantilla](obsidian/plantilla-tarea.md) para crear una nota por tarea
dentro de `Agentes/dotfiles` en tu vault. Incluye un alcance y un criterio de
aceptación por bloque. `Space y f` copia `ruta:línea` en modo normal y
`ruta:inicio-fin` en modo visual. La ruta parte de la raíz de Git. Sin
portapapeles del sistema, la referencia queda en el registro sin nombre.

Desde la raíz del repo, abre `claude` o `codex` en otra pestaña de la
terminal. Pídele que lea la nota con `obsidian-notes` y proponga un plan
para un bloque concreto. Autoriza su implementación en la conversación
cuando estés conforme. Revisa el resultado en Neovim y Lazygit antes de
hacer commit o abrir un PR. La nota se edita en Obsidian y el MCP entrega
solo herramientas de lectura.

### Configuración local del MCP

Necesitas Node.js 24 o posterior y `npm`. Instala la versión probada del
servidor. En WSL, convierte la ubicación Windows del vault con `wslpath -u`.
En Debian, usa la ruta local de tu vault. Selecciona solo la carpeta que
contiene las notas para este proyecto. Crea esa carpeta y copia allí la
plantilla y la nota piloto de `nvim/obsidian/` desde la raíz del repo.

```bash
npm install --prefix "$HOME/.local/share/obsidian-notes-mcp" --save-exact \
  --ignore-scripts @modelcontextprotocol/server-filesystem@2.4.0
server="$HOME/.local/share/obsidian-notes-mcp/node_modules/@modelcontextprotocol/server-filesystem/dist/index.js"
notes='/ruta/absoluta/al/vault/Agentes/dotfiles'
cd ~/dotfiles
claude mcp add --scope local --transport stdio obsidian-notes -- \
  "$(command -v node)" "$server" --read-only --confine-roots "$notes"
```

Para Codex, añade la siguiente entrada al `.codex/config.toml` local de la
raíz del repo. Sustituye las tres rutas por las de la máquina. Si el archivo
es nuevo y contiene datos locales, exclúyelo con `/.codex/config.toml` en
`.git/info/exclude`. Codex carga la configuración del repo cuando lo has
marcado como confiable.

```toml
[mcp_servers.obsidian-notes]
command = "/ruta/absoluta/a/node"
args = ["/ruta/absoluta/a/dist/index.js", "--read-only", "--confine-roots", "/ruta/al/vault/Agentes/dotfiles"]
```

Abre una sesión nueva y comprueba el servidor con `/mcp`. Por ejemplo,
puedes pedir `Lee piloto-referencias-neovim.md con obsidian-notes y resume B01`.
Usa una nota de prueba para comprobar la conexión antes de incorporarle
contenido de trabajo.

## Treesitter (resaltado avanzado de sintaxis)

Neovim 0.12 usa la rama `main` de `nvim-treesitter` e instala los
parsers al iniciar si están disponibles el compilador de C y el CLI
`tree-sitter`. Al migrar una instalación existente a Neovim 0.12, ejecuta
`:Lazy restore nvim-treesitter` y vuelve a abrir el editor. En Neovim
0.10 y 0.11 se usa la rama `master` y está disponible `:TSInstallSync`.

## Servidores LSP

Con Neovim abierto, usa Mason para instalar YAML, Terraform, Dockerfile,
Python, Bash y JSON.

```vim
:Mason
:MasonInstall yaml-language-server terraform-ls dockerfile-language-server pyright bash-language-server json-lsp
```

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
