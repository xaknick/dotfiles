local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}

-- OS recognition
local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_linux <const> = wezterm.target_triple:find("linux") ~= nil
local is_tiling <const> = os.getenv("HYPRLAND_CMD") ~= nil

-- Configuring Appearance
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.front_end = "WebGpu"
config.default_cursor_style = "SteadyBar"

config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
	"MesloLGS NF",
	"JetBrains Mono",
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
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20
config.window_padding = {
	bottom = 0,
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
}

-- OS related settings

-- MacOS
if is_darwin then
	config.font_size = 16.0
	wezterm.on("gui-startup", function()
		local tab, pane, window = mux.spawn_window({})
		window:gui_window():maximize()
	end)
	config.window_decorations = "RESIZE"

	-- Linux
elseif is_linux then
	config.font_size = 14

	-- Tiling WM
	if is_tiling then
		config.enable_wayland = true

		-- Regular WM
	else
		config.enable_wayland = false
		wezterm.on("gui-startup", function()
			local tab, pane, window = mux.spawn_window({})
			window:gui_window():toggle_fullscreen()
		end)
	end
end

return config
