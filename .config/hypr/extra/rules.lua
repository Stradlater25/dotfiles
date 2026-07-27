hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_out = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in  = 0 })
hl.window_rule({
		name  = "no-gaps-wtv1",
		match =	{ 
			float = false, 
			workspace = "w[tv1]"
		},
		border_size = 0,
		rounding    = 0,
})
hl.window_rule({
		name  = "no-gaps-f1",
		match = {
			float = false,
			workspace = "f[1]"
		},
		border_size = 0,
		rounding    = 0,
})

hl.window_rule({
    name = "Gimp float",
	match = {
			class = "gimp",
			title = "Preferences"
	},
	float = true,
	center = true
})

hl.window_rule({
	match = {
		class = "org.freedesktop.impl.portal.desktop.kde"
	},
	float = true,
	center = true,
	size = { 1200, 800}
})

hl.window_rule({
    name = "No blur for XWayland context menus",
    match = { xwayland = true},
    no_blur = true
})

hl.window_rule({
		name = "VLC Wayland fullscreen fix",
		match = {
				float = true,
				class = "vlc",
				title = "vlc"
		},
		border_size = false,
		decorate = true,
		no_focus = false 
})


hl.window_rule({
    match = { title = "^(mtiBalloon)$"},
    no_focus = true    
})

hl.window_rule({
    name = "Decorate floating window",
    match = { float = true },
    rounding = border_radius,
    border_size = border_width
})

hl.window_rule({
	match = { class = "^pavucontrol.*" },
	size = {"monitor_w * 0.5", "monitor_h * 0.5"},
	center = true,
	float = true
})

hl.window_rule({
		match = { class = "musicpresence" },
		float = true,
		center = true
})

hl.window_rule({
    name = "Open file dialog",
    match = {
	title = "^(Open File)(.*)$",
	title = "^(Select a File)(.*)$",
	title = "^(Open Folder)(.*)$",
	title = "^(Save As)(.*)$",
	class = "org.freedesktop.impl.portal.desktop.kde"
    },
    float = true,
    center = true
})

hl.window_rule ({
    name = "Discord PopOut",
	match = {
			initial_title = "Discord Popout",
	},
	pin = true,
	float = true
})

hl.window_rule ({
    name = "KDE Connect pointer",
    match = { class = "org.kde.kdeconnect.daemon"},
    size = {"monitor_w", "monitor_h"},
    no_blur = 1,
    opacity = 1,
    decorate = false,
    no_anim = 1,
    no_focus = true,
    pin = true,
    tile = false
})


hl.window_rule ({
    name = "TG Mini App",
    match = {
	title = "^(Mini App:)(.*)$ ",
	class = "(org.telegram.desktop)",
    },	
    float = true,
    center = true,
    no_blur = true,
    decorate = false,
    size = {410, 710}
})

hl.window_rule ({
    name = "Picture in picture",
    match = {
	title = "Picture-in-Picture"
    },
    -- float = true,
    suppress_event = "fullscreen maximize fullscreenoutput",
    -- sync_fullscreen = true,
    -- keep_aspect_ratio = true,
    -- pin = true
})

hl.window_rule ({
		name = "KeePassXC Pass Generator",
		match = {
				class = "org.keepassxc.KeePassXC",
				title = "Generate Password"
		},
		float = true
})


hl.window_rule ({
    name = "RyujinxOverlay",
    match = {
	class = "^(Ryujinx)",
	title = "ContentDialogOverlayWindow"
    },
    no_blur = true,
    decorate = false  
})

hl.window_rule ({
		name = "Screen picker", 
		match = {class = 'hyprland-share-picker'},
		float = true
})
