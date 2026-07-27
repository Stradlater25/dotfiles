--------------------------------------------------
---                KEYBINDINGS                 ---
--------------------------------------------------
local MOD   = "SUPER + "
local CTRL  = "CTRL  + "
local ALT   = "ALT   + "
local SHIFT = "SHIFT + "
local HYPR  = "MOD3  + "
local smw = hl.plugin.split_monitor_workspaces

local terminal = "kitty"
local fileManager = "dolphin"
local launcerh = "qs -c noctalia-shell ipc call launcher toggle"
local emacsclient = "emacsclient --create-frame"


local dirs = {
    { ["key"] = "k", ["dir"] = "up"	},
    { ["key"] = "j", ["dir"] = "down"	},
    { ["key"] = "l", ["dir"] = "right"	},
    { ["key"] = "h", ["dir"] = "left"	}
}


hl.bind(MOD .. 			"Return",	hl.dsp.exec_cmd(terminal))
hl.bind(MOD .. 			"e",		hl.dsp.exec_cmd(fileManager))
hl.bind(MOD .. 			"Space",	hl.dsp.exec_cmd(launcher))
hl.bind(MOD ..			"o",		hl.dsp.exec_cmd(emacsclient))
hl.bind(MOD .. SHIFT .. "S",		hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(MOD ..			"z",		hl.dsp.window.close())
hl.bind(MOD .. 			"v",		hl.dsp.window.float({ action = "toggle" }))
hl.bind(MOD .. SHIFT .. "q",		hl.dsp.exit())

-- WORKSPACES --
hl.bind(MOD .. 			"TAB",		hl.dsp.focus({ workspace = "previous"}))
hl.bind(MOD .. SHIFT .. "TAB", function () return  smw.change_monitor("next") end)
hl.bind(MOD .. ALT   ..	"TAB", 		hl.dsp.focus({ monitor = "+1"}))

for i=0,9 do
    hl.bind(MOD .. " + " .. tostring(i),
	    function () return smw.workspace(i) end)
    hl.bind(MOD .. " + SHIFT + " .. tostring(i),
	    function () return smw.move_to_workspace(i) end)
end

hl.bind(MOD .. ALT .. "j",	function () return smw.cycle_workspaces("next") end)
hl.bind(MOD .. ALT .. "k",	function () return smw.cycle_workspaces("prev") end)
hl.bind(MOD .. "mouse_down",	function () return smw.cycle_workspaces("next") end)
hl.bind(MOD .. "mouse_up",	function () return smw.cycle_workspaces("prev") end)

for _, cur in pairs(dirs) do
    hl.bind(MOD .. " + " .. cur.key,  hl.dsp.focus({ direction = cur.dir }))
end

-- SCROLLING --
hl.bind(MOD .. SHIFT .. "h", hl.dsp.layout("colresize -0.1"))
hl.bind(MOD .. SHIFT .. "l", hl.dsp.layout("colresize +0.1"))
hl.bind(MOD .. "r", hl.dsp.layout("swapcol r"))
hl.bind(MOD .. SHIFT .. "r", hl.dsp.layout("swapcol l"))
hl.bind(MOD .. "mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(MOD .. "mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(MOD .. SHIFT .. "mouse_up", hl.dsp.layout("focus left")) 
hl.bind(MOD .. SHIFT .. "mouse_down", hl.dsp.layout("focus right"))




-- Example special workspace (scratchpad)
hl.bind(MOD .. "S",         hl.dsp.workspace.toggle_special("magic"))
--hl.bind(MOD .. SHIFT .. "S", hl.dsp.window.move({ workspace = "special:magic" }))

--hl.bind(	" + XF86Tools", hl.dsp.exec_cmd("echo 'VCD_TOGGLE_SELF_MUTE' >> $XDG_RUNTIME_DIR/vesktop-ipc"))
--hl.bind(MOD ..	" + XF86Tools", hl.dsp.exec_cmd("echo 'VCD_TOGGLE_SELF_DEAF' >> $XDG_RUNTIME_DIR/vesktop-ipc"))
-- hl.bind( "mouse:191", hl.dsp.exec_cmd("ydotool key 194:1 194:0"))
-- hl.bind( "mouse:191", hl.dsp.pass({ window = "class:^(discord)$"}))
hl.bind( "mouse:191", hl.dsp.exec_cmd("ydotool key 194"))
hl.bind( "mouse:191", hl.dsp.exec_cmd("ydotool keyup 194"), { release = true })
hl.bind( "mouse:191", hl.dsp.pass({ window = "class:Spotify"}))
hl.bind(MOD .. "f", hl.dsp.window.pin({ action = "toggle"}))


-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
	{ locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
	{ locked = true, repeating = true })

hl.bind(MOD .. "+ bracketright", function()
                 hl.timer(function()
                   hl.dispatch(hl.dsp.dpms({ action = "disable" }))
                 end, {timeout = 500, type = "oneshot"})
               end)

hl.bind(MOD .. "+ SHIFT + bracketright", function()
                 hl.timer(function()
                   hl.dispatch(hl.dsp.dpms({ action = "enable" }))
                 end, {timeout = 500, type = "oneshot"})
               end)


-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(HYPR .. "a",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("code:173",  hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("code:171",  hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
