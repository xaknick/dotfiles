local wezterm = require("wezterm")

local M = {}

function M.setup()
	local is_darwin = wezterm.target_triple:find("darwin") ~= nil

	local keys = {
		-- Enter as literal newline when some apps capture Enter weirdly (keep yours)
		{ key = "Enter",      mods = "SHIFT",      action = wezterm.action.SendString("\n") },
		-- Clear screen (viewport) like IDE
		{ key = "L",          mods = "CTRL",       action = wezterm.action.ClearScrollback("ScrollbackAndViewport") },
		-- Pane management (built-in splits)
		{ key = "Enter",      mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "Enter",      mods = "CTRL|ALT",   action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "W",          mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
		{ key = "LeftArrow",  mods = "ALT",        action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "RightArrow", mods = "ALT",        action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "UpArrow",    mods = "ALT",        action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "DownArrow",  mods = "ALT",        action = wezterm.action.ActivatePaneDirection("Down") },
		-- Tab navigation (browser-like)
		{ key = "Tab",        mods = "CTRL",       action = wezterm.action.ActivateTabRelative(1) },
		{ key = "Tab",        mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	}

	-- Platform-specific UX: macOS uses Command for clipboard, Linux uses Ctrl.
	if is_darwin then
		-- macOS: keep Unix semantics on Ctrl+C (SIGINT), use ⌘ for clipboard
		table.insert(keys, { key = "c", mods = "CMD", action = wezterm.action.CopyTo("Clipboard") })
		table.insert(keys, { key = "v", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") })
	else
		-- Linux/other: modern IDE-like Ctrl+C/V for clipboard, Shift+Ctrl+C for SIGINT
		table.insert(keys, { key = "c", mods = "CTRL", action = wezterm.action.CopyTo("Clipboard") })
		table.insert(keys, { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") })
		table.insert(keys, { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.SendKey({ key = "c", mods = "CTRL" }) })
	end

	return keys
end

return M
