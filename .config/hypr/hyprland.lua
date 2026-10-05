require("extra/consts")
require("extra/rules")
require("extra/keybinds")
require("extra/animations")

hl.monitor({
    output = "DP-1",
    mode = "1920x1080@165",
    position = "0x0",
    scale = 1.0,
    vrr = 0
})

-- landscape
-- hl.monitor({
--     output = "HDMI-A-1",
--     mode = "1920x1080@60",
--     scale = 1,
--     position = "1920x0"
-- })

-- portrait
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    scale = 1,
    transform = 1,
    position = "1920x-540"
})


hl.config({
    xwayland = {
        enabled = true,
        create_abstract_socket = true
    }}
)


hl.on("hyprland.start",
      function ()
          hl.exec_cmd("noctalia")
          hl.exec_cmd("systemctl --user start hyprpolkitagent")
          hl.exec_cmd("dbus-update-activation-environment --all")
          hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
          hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
          hl.exec_cmd("wl-paste --watch cliphist store")
          hl.exec_cmd("hyprpm reload")
          hl.exec_cmd("/home/stradlater/LibreWebTools/TgWsProxy_linux_amd64 &")
          hl.exec_cmd("cat .config/.kpp | keepassxc --minimized ~/Documents/Passwords.kdbx --pw-stdin")
      end
)


for i = 1, 20 do
    hl.workspace_rule({ workspace = tostring(i), default_name = tostring(i) })
end
hl.workspace_rule({workspace = "10", default_name = "X"})
hl.workspace_rule({workspace = "20", default_name = "X"})

hl.config({
    general = {
		gaps_in = gaps_in ,
		gaps_out = gaps_out,
		border_size = border_width,
		layout = "scrolling",
		no_focus_fallback = true
    },
    decoration = {
		rounding = border_radius,
		blur = {
			size = 6,
			passes = 2
		},
		shadow = {
		    enabled = false,
		}
    },
    binds = {
		window_direction_monitor_fallback = false
    },
    scrolling = {
		fullscreen_on_one_column = true,
		column_width = 0.5,
		direction = "right",
		wrap_swapcol = false,
		wrap_focus = false
    },
    misc = {
		force_default_wallpaper = 1,
		disable_hyprland_logo = true,
    },
    cursor = {
		no_hardware_cursors = true
	},
    input = {
		kb_layout = "us,ru",
		kb_options = "strd:capshyper,strd:composemenu,strd:capsshifts",
		repeat_delay = 220,
		repeat_rate = 60
    }
})


-- PLUGIN CONFIG
hl.config({
    plugin = {
        split_monitor_workspaces = {
            count                        = 10,
            keep_focused                 = true,
            enable_notifications         = 0,
            enable_persistent_workspaces = 1,
            enable_wrapping              = false,
            link_monitors                = 0,
            -- enable_hy3                = 1,
        },
    }
})


hl.layer_rule {
    name = "noctalia",
    match = { namespace = "noctalia-.*$" },
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = false
}

-- For Noctalia Color templates
require("noctalia").apply_theme()

