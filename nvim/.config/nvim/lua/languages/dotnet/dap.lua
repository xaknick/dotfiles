local M = {}

function M.setup()
	local dap = require("dap")

	-- Only configure debugging sessions - adapter setup handled by mason-nvim-dap
	dap.configurations.cs = {
		{
			type = "coreclr",
			name = "Launch .NET",
			request = "launch",
			program = function()
				return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
			end,
		},
	}
end

return M
