-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.adjust_window_size_when_changing_font_size = false
config.automatically_reload_config = true
config.color_scheme = 'Sandcastle (base16)'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
-- config.color_scheme = 'Kanagawa (Gogh)'
config.disable_default_key_bindings = false
config.font - wezterm.font('Cica')
config.font_size = 18.0
config.force_reverse_video_cursor = true
config.hide_tab_bar_if_only_one_tab = true
config.use_ime = true
-- config.window_background_opacity = 0.8
config.window_decorations = 'RESIZE'
config.window_frame = {
	inactive_titlebar_bg = 'none',
	active_titlebar_bg = 'none'
}
config.window_padding = {
	left = 2,
	right = 2,
	top = 3,
	bottom = 0,
}

-- Finally, return the configuration to wezterm:
return config
