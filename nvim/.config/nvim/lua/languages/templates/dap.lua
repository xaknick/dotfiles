local M = {}

function M.setup()
	local dap = require("dap")

	-- Only configure debugging sessions
	-- Adapters are handled by mason-nvim-dap automatically
	dap.configurations.FILETYPE = {
		{
			type = "adapter_name",
			name = "Debug description",
			request = "launch",
			program = "${file}", -- or function for custom input
			-- Additional debug configuration
		},
		{
			type = "adapter_name",
			name = "Debug with args",
			request = "launch",
			program = "${file}",
			args = function()
				return vim.split(vim.fn.input("Args: "), " ")
			end,
		},
	}
end

return M
