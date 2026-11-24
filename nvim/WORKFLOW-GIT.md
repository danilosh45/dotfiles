# Git desde Neovim con Lazygit

Un recorrido para crear una rama, revisar cambios por bloques, escribir un Conventional Commit y abrir un PR. Los atajos corresponden a la configuración de estos dotfiles y a la versión de Lazygit instalada.

## Atajos de Neovim

Abre Neovim desde un directorio del repo. `<leader>` es `Space`.

| Atajo en modo normal | Acción |
| --- | --- |
| `Space g g` o `:LazyGit` | Abre Lazygit en una pestaña, desde la raíz del repositorio. |
| `Space g p` o `:GitPR` | Abre el menú de GitHub. Permite crear un borrador, ver el PR, revisar el diff, consultar los checks o abrirlo en el navegador. |
| `Space y f` | Copia `ruta:línea` desde la raíz Git. En modo visual copia `ruta:inicio-fin`. Úsalo para señalar código en Obsidian o durante la revisión. |
| `:Gitsigns preview_hunk` | Muestra el cambio bajo el cursor. |
| `:Gitsigns blame_line` | Muestra la autoría y el commit de la línea. |

Al salir de Lazygit con `q`, puedes cerrar la pestaña del terminal con `:tabclose`. Pulsa `Ctrl-\` y luego `Ctrl-n` si sigues en modo terminal.

## Atajos dentro de Lazygit

La acción de algunas teclas depende del panel activo. `?` abre la ayuda del panel.

| Panel | Tecla | Acción |
| --- | --- | --- |
| Cualquiera | `2` / `3` / `4` | Ir a **Files**, **Branches** o **Commits**. |
| Cualquiera | `j` / `k` | Bajar o subir por la lista. |
| **Files** | `Space` | Preparar o retirar del staging el archivo seleccionado. |
| **Files** | `Enter` | Entrar en el diff para preparar partes del archivo. |
| Diff de **Files** | `a`, después `Space` | Alternar la selección de un bloque completo y preparar la selección. |
| **Files** | `Ctrl-v` | Abrir el formulario de Conventional Commits de esta configuración. |
| **Files** | `c` | Abrir el editor de mensaje integrado de Lazygit. |
| **Files** | `f` | Hacer fetch y actualizar las referencias remotas. |
| **Branches** | `n` | Crear una rama desde la rama seleccionada. Comprueba qué rama has resaltado. |
| **Branches** | `Space` | Cambiar a la rama seleccionada. |
| Cualquiera | `P` | Subir la rama actual. Úsalo cuando ya tenga su upstream correcto. |
| Cualquiera | `Esc` / `q` | Volver al panel anterior o salir de Lazygit. |

## Recorrido habitual

### 1. Identifica el repo, la rama y el autor

```bash
git status -sb
git branch -vv
git remote -v
git var GIT_AUTHOR_IDENT
```

En esta máquina, la identidad personal de los dotfiles se configura en el repo y la corporativa es la predeterminada. `git var GIT_AUTHOR_IDENT` muestra la autoría efectiva y `gh auth status --hostname github.com` indica qué cuentas tienen sesión en GitHub CLI. Comprueba la identidad efectiva y el remoto cuando cambies entre proyectos.

### 2. Crea una rama desde la base actualizada

Para empezar una tarea nueva con el árbol de trabajo limpio, actualiza la referencia remota y crea la rama desde ella. Sustituye `main` si el proyecto usa otra base.

```bash
git fetch origin
git switch -c fix/nvim-completion origin/main
```

Si ya tienes una rama para la tarea, comprueba lo que lleva con `git log --oneline origin/main..HEAD`. Si el agente implementa un bloque, deja que termine antes de preparar el diff.

### 3. Revisa y prepara solo lo que pertenece al commit

1. Abre `Space g g`, pulsa `2` y revisa los archivos en **Files**.
2. Usa `Space` para preparar un archivo entero. Si un archivo mezcla cambios, entra con `Enter`, selecciona el bloque o las líneas y pulsa `Space` dentro del diff.
3. Si preparaste un archivo por error, vuelve a seleccionarlo y retíralo del staging. Quitar un cambio del staging conserva la edición en el archivo.
4. Ejecuta las comprobaciones del bloque. Antes del commit, repasa el contenido exacto que va a entrar.

```bash
git diff                 # Cambios sin preparar
git diff --cached        # Cambios que entrarán en el próximo commit
git diff --cached --check
```

Puedes pasar a la terminal y usar `git add -p -- ruta/al/archivo` para preparar bloques uno a uno. Si una corrección del editor y una mejora de la documentación tienen motivos distintos, prepara y commitea cada una por separado.

### 4. Escribe el Conventional Commit

En **Files**, pulsa `Ctrl-v`. El formulario pide tipo, ámbito opcional, resumen y un cuerpo opcional. Elige `fix` para errores, `feat` para funcionalidad, `docs` para documentación o `refactor` para cambios de estructura sin cambio de comportamiento. El ámbito puede ser `nvim`, `yazi` o el componente que has tocado.

Ejemplo de mensaje:

```text
fix(nvim): corrige el autocompletado en Telescope

Usa las opciones de selección que admite Blink al entrar en el selector.
```

El formulario muestra el título antes de confirmar y ejecuta `git diff --cached --check`. Comprueba el resultado en **Commits** con `4` o con `git show --stat HEAD`.

### 5. Sube la rama y abre un borrador

Para el primer push de una rama de trabajo, indica el remoto y la rama explícitamente. Es especialmente útil si `git branch -vv` muestra `origin/main` como upstream de tu rama de trabajo.

```bash
git push -u origin HEAD
git branch -vv
```

Una vez vinculada a `origin/<tu-rama>`, usa `P` en Lazygit para los pushes posteriores. En Neovim, pulsa `Space g p` y elige **Crear borrador**. Confirma la rama base y explica en el cuerpo del PR qué querías resolver, qué cambiaste y cómo lo probaste. Para cambios visibles, añade una captura si ayuda a revisar.

En GitHub CLI, el mismo flujo se puede seguir desde la terminal.

```bash
gh pr create --draft --base main
gh pr diff
gh pr checks
gh pr ready
```

Ejecuta `gh pr ready` cuando quieras solicitar revisión. Después de las revisiones y los checks requeridos, haz el merge desde GitHub según la política del proyecto. En GitLab el equivalente es un MR. Abre uno con `glab mr create` desde tu rama del repo de GitLab.

## Cuando la rama base avanza

Si necesitas incorporar cambios de `main` a una rama de trabajo ya publicada, revisa primero que el árbol esté limpio. Un merge permite integrar la base sin reescribir los commits de la rama.

```bash
git fetch origin
git merge origin/main
```

Si hay conflictos, revisa cada archivo en Neovim, ejecuta las pruebas y prepara las resoluciones en Lazygit. `git status` indica cómo continuar. Si prefieres cancelar el merge en curso, usa `git merge --abort`. Cuando quede resuelto, sube la rama y vuelve a revisar el PR.

Tras el merge remoto, cambia a `main` y sincroniza tu copia local con avance rápido.

```bash
git switch main
git pull --ff-only origin main
```
