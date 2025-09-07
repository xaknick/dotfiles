local M = {}

-- LSP-related plugins (loaded as dependencies for the LSP plugin)
-- These are loaded before LSP setup to ensure they're available for LSP configurations
M.lsp_plugins = {
	-- Example: "plugin/for-lsp-enhancement"
}

-- General language-specific plugins (loaded independently)
-- These can include testing frameworks, syntax highlighting, file manipulation, etc.
M.plugins = {
	-- Example with filetype restriction and configuration:
	-- {
	-- 	"plugin/name",
	-- 	ft = { "filetype1", "filetype2" },
	-- 	config = function()
	-- 		require("plugin").setup({
	-- 			-- Plugin configuration
	-- 		})
	-- 	end,
	-- },
}

return M