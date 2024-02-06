local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config = {
	color_scheme = "biscuit-dark",
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	window_decorations = "RESIZE",
	enable_wayland = false,
}

return config
