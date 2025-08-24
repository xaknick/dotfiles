local M = {}

-- LSP servers to install via Mason
M.servers = { "server_name" }

function M.setup()
	-- Option 1: Use defaults (just return, no config needed)
	-- return

	-- Option 2: Custom configuration
	vim.lsp.config("server_name", {
		settings = {
			-- Server-specific settings
		},
		-- Custom handlers, capabilities, etc.
	})

	-- Option 3: Language-specific keymaps
	vim.keymap.set("n", "<leader>cx", function()
		-- Custom command
	end, { desc = "Custom action" })
end

return M
