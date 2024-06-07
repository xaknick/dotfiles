local wezterm = require 'wezterm'
local config = {}

-- Configuring Appearance
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'MesloLGS NF'
config.font_size = 16.0
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.0,
  brightness = 0.9,
}

-- Resolution
config.initial_cols = 140
config.initial_rows = 50

-- Key bindings 
config.keys = {
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 't',
    mods = 'ALT|SHIFT',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = wezterm.home_dir
    },
  }
}

-- Maximizing window while starting up
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

return config

