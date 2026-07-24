hl.on("hyprland.start", function()
    hl.exec_cmd("waybar > /dev/null 2>&1 &")
    hl.exec_cmd("hyprpaper > /dev/null 2>&1 &")
    hl.exec_cmd("mako > /dev/null 2>&1 &")
    hl.exec_cmd("nm-applet --indicator > /dev/null 2>&1 &")
    hl.exec_cmd("wl-paste --type text --watch cliphist store > /dev/null 2>&1 &")
    hl.exec_cmd("wl-paste --type image --watch cliphist store > /dev/null 2>&1 &")
    hl.exec_cmd("lxqt-policykit-agent > /dev/null 2>&1 &")
    hl.exec_cmd("blueman-applet > /dev/null 2>&1 &")
    
    -- IDLE MANAGER: siempre corriendo, detecta hyprlock
    hl.exec_cmd("~/.local/bin/idle-manager > /dev/null 2>&1 &")
end)
