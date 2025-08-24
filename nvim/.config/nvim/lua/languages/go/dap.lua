local M = {}

M.adapters = { "delve" }

function M.setup()
	local dap = require("dap")

	-- Only configure debugging sessions - adapter setup handled by mason-nvim-dap
	dap.configurations.go = {
		{
			type = "go",
			name = "Debug file",
			request = "launch",
			program = "${file}",
		},
		{
			type = "go",
			name = "Debug package",
			request = "launch",
			program = "${workspaceFolder}",
		},
	}
end

return M
