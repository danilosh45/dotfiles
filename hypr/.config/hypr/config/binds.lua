----------------------------------------
--  ATAJOS DE TECLADO
----------------------------------------

-- Básicos
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("wl-paste"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Focus entre ventanas
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Screenshots
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.local/bin/screenshot-area"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("~/.local/bin/screenshot-window"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.local/bin/screenshot-full"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("~/.local/bin/screenshot-edit"))

-- Workspaces (1-10)
for i = 1, 10 do
    local key = (i == 10) and "0" or tostring(i)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Mouse: mover y redimensionar ventanas
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia ThinkPad
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pamixer -i 5 && notify-send -h int:value:$(pamixer --get-volume) -t 800 'Volumen'"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pamixer -d 5 && notify-send -h int:value:$(pamixer --get-volume) -t 800 'Volumen'"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pamixer -t && notify-send -t 800 'Audio' 'Mute toggled'"), { locked = true })

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s +5% && notify-send -h int:value:$(brightnessctl -m | cut -d, -f4 | tr -d %) -t 800 'Brillo'"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%- && notify-send -h int:value:$(brightnessctl -m | cut -d, -f4 | tr -d %) -t 800 'Brillo'"), { locked = true, repeating = true })

-- Bluetooth manager
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("blueman-manager"))
