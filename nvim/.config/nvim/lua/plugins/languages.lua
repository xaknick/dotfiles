-- Collect and load all language-specific plugins
local language_plugins = require("languages").get_plugins()

-- Convert the simple plugin list into proper Lazy.nvim specs if needed
local function normalize_plugin_spec(plugin)
	if type(plugin) == "string" then
		-- Simple plugin name, return as-is
		return plugin
	else
		-- Already a plugin spec table
		return plugin
	end
end

local plugins = {}
for _, plugin in ipairs(language_plugins) do
	table.insert(plugins, normalize_plugin_spec(plugin))
end

return plugins