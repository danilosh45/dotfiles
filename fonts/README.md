# `fonts/` — Módulo dotfiles para fuentes

Fuentes gestionadas vía GNU Stow. Se enlazan en `~/.local/share/fonts/`.

## Instaladas

### Hack v3.003
Fuente monoespaciada diseñada para código. Versiones Regular, Italic, Bold, BoldItalic.

- Origen: <https://github.com/source-foundry/Hack>
- Licencia: MIT + SIL OFL (Hack) — bitstream vera (BDF) + DejaVu

## Instalación

```bash
cd ~/dotfiles
stow --restow --target="$HOME" fonts
fc-cache -f
fc-list | grep Hack
```

## Añadir una fuente nueva

1. Descarga el `.ttf` / `.otf` / `.zip`.
2. Cópialo dentro de la jerarquía versionada:
   ```
   fonts/.local/share/fonts/<NombreFuente>/...
   ```
3. `stow --restow fonts && fc-cache -f`.

## Notas

- No uses `~/.fonts/` (deprecated desde fontconfig 2.12).
- Si la fuente ya existía en el sistema, primero bórrala del destino antes
  de stow para que cree un symlink limpio (ver comandos arriba).