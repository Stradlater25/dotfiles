-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("easeInOutCirc",  { type = "bezier", points = { {0.85, 0},    {0.15, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
hl.curve("rubber",         { type = "spring", mass = 1, stiffness = 70,      dampening = 10         })
hl.curve("default",        { type = "spring", mass = 1, stiffness = 300,     dampening = 20         })

-- hl.animation({ leaf = "windows",    speed = 0.1, spring = "rubber",        style = "popin 80%",     enabled = true})
hl.animation({ leaf = "windows",     speed = 1,    spring = "default",       style = "slide down",    enabled = true })
hl.animation({ leaf = "windowsMove", speed = 0.78, bezier = "easeInOutCirc", style = "popin",         enabled = true })
hl.animation({ leaf = "workspaces",  speed = 1.6,  bezier = "easeInOutCirc", style = "slidefadevert", enabled = true }) -- OK


-- hl.animation({ leaf = "global",        enabled = true,  speed = 0.5,   bezier = "default" })
-- hl.animation({ leaf = "border",        enabled = true,  speed = 0.39, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "windows",       enabled = true,  speed = 0.79, spring = "easy" })
-- hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 0.1,  spring = "easy",         style = "popin 87%" })
-- hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 0.09, bezier = "linear",       style = "popin 87%" })
-- hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 0.73, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
-- hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
-- hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "layersIn",      enabled = true,  speed = 0.45,    bezier = "easeOutQuint", style = "fade" })
-- hl.animation({ leaf = "layersOut",     enabled = true,  speed = 0.5,  bezier = "linear",       style = "fade" })
-- hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })

-- hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.2, bezier = "quick", style = "slidevert" })
-- -- hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
-- -- hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })

-- hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })
