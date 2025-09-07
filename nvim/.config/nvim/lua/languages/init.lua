local M = {}

-- Available languages
local languages = { "lua", "go", "typescript", "dotnet", "yaml", "rust", "json" }

-- Get all LSP servers across languages
function M.get_lsp_servers()
	local servers = {}
	for _, lang in ipairs(languages) do
		local ok, lang_config = pcall(require, "languages." .. lang .. ".lsp")
		if ok and lang_config.servers then
			vim.list_extend(servers, lang_config.servers)
		end
	end
	return servers
end

-- Get all tools (formatters, linters) across languages
function M.get_tools()
	local tools = {}
	for _, lang in ipairs(languages) do
		local ok, lang_config = pcall(require, "languages." .. lang .. ".tools")
		if ok and lang_config.tools then
			vim.list_extend(tools, lang_config.tools)
		end
	end
	return tools
end

-- Get all DAP adapters across languages
function M.get_dap_adapters()
	local adapters = {}
	for _, lang in ipairs(languages) do
		local ok, lang_config = pcall(require, "languages." .. lang .. ".dap")
		if ok and lang_config.adapters then
			vim.list_extend(adapters, lang_config.adapters)
		end
	end
	return adapters
end

-- Get all formatter configurations
function M.get_formatters()
	local formatters = {}
	for _, lang in ipairs(languages) do
		local ok, lang_config = pcall(require, "languages." .. lang .. ".tools")
		if ok and lang_config.formatters then
			formatters = vim.tbl_deep_extend("force", formatters, lang_config.formatters)
		end
	end
	return formatters
end

-- Get LSP-related plugins (for LSP plugin dependencies)
function M.get_lsp_plugins()
	local plugins = {}
	for _, lang in ipairs(languages) do
		local ok, lang_config = pcall(require, "languages." .. lang .. ".plugins")
		if ok and lang_config.lsp_plugins then
			vim.list_extend(plugins, lang_config.lsp_plugins)
		end
	end
	return plugins
end

-- Get general language-specific plugins (for independent loading)
function M.get_plugins()
	local plugins = {}
	for _, lang in ipairs(languages) do
		local ok, lang_config = pcall(require, "languages." .. lang .. ".plugins")
		if ok and lang_config.plugins then
			vim.list_extend(plugins, lang_config.plugins)
		end
	end
	return plugins
end

-- Load all LSP configurations
function M.load_lsp_configs()
	for _, lang in ipairs(languages) do
		local ok, lang_config = pcall(require, "languages." .. lang .. ".lsp")
		if ok and lang_config.setup then
			lang_config.setup()
		end
	end
end

-- Load all DAP configurations
function M.load_dap_configs()
	for _, lang in ipairs(languages) do
		local ok, lang_config = pcall(require, "languages." .. lang .. ".dap")
		if ok and lang_config.setup then
			lang_config.setup()
		end
	end
end

return M
