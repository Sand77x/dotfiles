return function(config)
	config.color_scheme = "OceanicNext (base16)"
	config.window_background_opacity = 1.0
	config.adjust_window_size_when_changing_font_size = false

	-- config.font = require("wezterm").font("GeistMono Nerd Font", { weight = "Medium" })
	-- config.line_height = 1.2
	-- config.cell_width = 0.9
	-- config.font_size = 16.0
	config.font = require("wezterm").font("Iosevka Term Medium Extended", { weight = "Regular" })
	config.line_height = 1.1
	config.cell_width = 1
	config.font_size = 14.0

	config.freetype_render_target = "HorizontalLcd"
	config.freetype_load_flags = "NO_HINTING"
	config.force_reverse_video_cursor = true
	config.front_end = "OpenGL"

	config.max_fps = 120

	config.background = {
		{
			source = {
				File = require("wezterm").config_dir .. "\\backgrounds\\shinobuflipped.jpg",
			},
			attachment = "Fixed",
			width = "Cover",
			vertical_align = "Middle",
			horizontal_align = "Right",
		},
		{
			source = {
				Color = "black",
			},
			width = "100%",
			height = "100%",
			opacity = 0.8,
		},
	}
end
