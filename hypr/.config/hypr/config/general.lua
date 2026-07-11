----------------------------------------
--  CONFIGURACIÓN OSCURO EFICIENTE
--  Sin blur pesado, sin transparencias excesivas
----------------------------------------

hl.curve("default", { type = "bezier", points = { {0.25, 0.46}, {0.45, 0.94} } })

hl.animation({ leaf = "windows", enabled = false, speed = 8, bezier = "default" })
hl.animation({ leaf = "border", enabled = false, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = false, speed = 8, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = false, speed = 6, bezier = "default" })

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = "rgba(137, 180, 250, 0.9)",
            inactive_border = "rgba(88, 91, 112, 0.5)",
        },
        layout = "dwindle",
    },

    decoration = {
        rounding = 8,
        active_opacity = 1.0,
        inactive_opacity = 0.95,
        fullscreen_opacity = 1.0,

        -- Sin blur = menos GPU, más batería
        blur = {
            enabled = false,
        },

        -- Sin sombras = menos GPU
        shadow = {
            enabled = false,
        },

        dim_inactive = false,
    },

    input = {
        kb_layout = "us",
        kb_options = "ctrl:nocaps",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
        },
    },

    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 1,
    },
})
