terminal = "kitty"
fileManager = "dolphin"
--launcher = "qs -c noctalia-shell ipc call launcher toggle"
launcher = "noctalia msg panel-toggle launcher"

border_width = 1
border_radius = 12
gaps_in = 4
gaps_out = 8


hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", 20)
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", 20)
hl.env("XDG_MENU_PREFIX", "arch-")

-- QT --
hl.env("QT_IM_MODULE", "fcitx")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", 1)
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", 1)

-- XDG --
hl.env("XDG_SESSION_TYPE",    "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- OTHER --
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("GDK_SCALE",	                   1)
hl.env("GDK_DPI_SCALE",	               1)
hl.env("GDK_BACKEND",                  "wayland,x11,*")
hl.env("TERMINAL",	                   "kitty")
hl.env("TERM",		                   "kitty")
hl.env("EDITOR",                       "nvim")
hl.env("VISUAL",                       "nvim")
