local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}

-- OS recognition
local is_darwin = wezterm.target_triple:find("darwin") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil
local defined_font = os.getenv("WEZTERM_FONT")

-- Configuring Appearance
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_cursor_style = "SteadyBar"

config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
	defined_font or "JetBrains Mono",
})
config.foreground_text_hsb = {
	hue = 1.0,
	saturation = 1.0,
	brightness = 0.9,
}

-- -- Resolution
-- config.initial_cols = 140
-- config.initial_rows = 50

-- Window decoration
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.99
config.macos_window_background_blur = 20
config.window_padding = {
	bottom = 0,
}

-- Configure scrolling
config.enable_scroll_bar = true
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "NONE",
		action = wezterm.action.ScrollByLine(-2), -- change 2 to your desired number of lines
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "NONE",
		action = wezterm.action.ScrollByLine(2), -- change 2 to your desired number of lines
	},
}

-- Key bindings
config.keys = {
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "t",
		mods = "ALT|SHIFT",
		action = wezterm.action.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
		}),
	},
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action.SendString("\n"),
	},
}
config.window_close_confirmation = "NeverPrompt"

-- OS related settings
-- MacOS
if is_darwin then
	config.font_size = 16.0
	wezterm.on("gui-startup", function()
		local _, _, window = mux.spawn_window({})
		window:gui_window():maximize()
	end)
	config.window_decorations = "RESIZE"
	-- Linux
elseif is_linux then
	config.enable_wayland = true
	config.font_size = 12
	wezterm.on("gui-startup", function()
		local _, _, window = mux.spawn_window({})
		window:gui_window():maximize()
	end)
end

return config
