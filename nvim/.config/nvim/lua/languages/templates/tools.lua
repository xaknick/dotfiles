local M = {}

-- Tools to install via Mason (linters, formatters, etc.)
M.tools = { "tool1", "tool2" }

-- Conform.nvim formatter configuration
M.formatters = {
	filetype1 = { "formatter1" },
	filetype2 = { "formatter1", "formatter2", stop_after_first = true },
}

return M
