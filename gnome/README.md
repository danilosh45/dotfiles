# `gnome/` — Módulo dotfiles para GNOME

Configuración de GNOME (Debian + Wayland) gestionada con **GNU Stow** y **dconf**.

## 📦 Contenido

```
gnome/
├── dconf/
│   ├── gnome.dconf        # Keybindings de GNOME (dconf dump/load)
│   └── flameshot.ini      # Config de flameshot -> ~/.config/flameshot/flameshot.ini
├── local/
│   └── bin/
│       └── flameshot-screenshot.sh  # Wrapper anti "error al guardar" en Wayland
├── bootstrap.sh           # Aplica stow + dconf + reinicia portal
└── README.md
```

## 🚀 Instalación

```bash
cd ~/dotfiles
./gnome/bootstrap.sh
```

## ⌨️ Atajos

| Combinación              | Acción |
|--------------------------|--------|
| `<Super>Return`          | Abre terminal |
| `<Shift><Super>s`        | Captura de pantalla (wrapper flameshot) |
| `<Super>r`               | Grabación de pantalla |
| `Print`                  | Screenshot nativo (pantalla completa) |
| `<Shift>Print`           | Screenshot nativo (con UI) |
| `<Alt>Print`             | Screenshot nativo (ventana) |

## 🖼️ Captura de pantalla

El wrapper `flameshot-screenshot.sh`:

1. Crea `~/Pictures/Screenshots/` si falta.
2. Lanza `flameshot gui --path ... --clipboard`.
3. Si flameshot falla (típico en Wayland sin portal listo), hace **fallback**
   a `grim` + `slurp` + `wl-copy`.

### Dependencias (Debian)

```bash
sudo apt install -y flameshot xdg-desktop-portal xdg-desktop-portal-gnome \
  wl-clipboard grim slurp
```

## 🔧 Editar

Si modificas los atajos con la GUI de GNOME y quieres sincronizarlos:

```bash
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ \
  > ~/dotfiles/gnome/dconf/gnome.dconf
```

(También queda el snapshot completo cargado por `bootstrap.sh`.)