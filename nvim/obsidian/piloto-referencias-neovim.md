# Piloto · Copiar referencias de código desde Neovim

## Contexto

- Repositorio: `danilosh45/dotfiles`.
- Objetivo: pegar en Obsidian una referencia de código que se pueda usar desde WSL y Debian.
- Esta nota registra el trabajo. La autorización de cada bloque se da en la conversación con el agente.

## B01 · Copiar la ruta y las líneas

- **Alcance:** añadir `Space y f` en modo normal y visual.
- **Criterios de aceptación:** con el cursor en un archivo del repo, copiar `ruta:línea`; con una selección, copiar `ruta:inicio-fin`. La ruta debe partir de la raíz del repo, también si Neovim se abrió desde un subdirectorio.
- **Estado:** listo para revisión manual.

## B02 · Revisar y decidir si se publica

- **Alcance:** probar el atajo en Windows Terminal y pegar una referencia aquí. Revisar el diff en Lazygit antes de preparar el commit.
- **Criterio de aceptación:** Obsidian recibe la referencia esperada y el diff del atajo coincide con B01.
- **Estado:** pendiente de revisión del usuario.

## Resultado

- Referencia pegada durante la revisión:
- Comprobaciones manuales:
- Commit o PR, cuando corresponda:
