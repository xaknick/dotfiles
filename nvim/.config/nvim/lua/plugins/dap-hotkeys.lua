return {
	{
		"mfussenegger/nvim-dap",
		keys = function()
			local dap = require("dap")
			return {
				{ "<F5>", dap.continue, desc = "DAP Continue", mode = "n" },
				{ "<F10>", dap.step_over, desc = "DAP Step Over", mode = "n" },
				{ "<F11>", dap.step_into, desc = "DAP Step Into", mode = "n" },
				{ "<F12>", dap.step_out, desc = "DAP Step Out", mode = "n" },
				{ "<F9>", dap.toggle_breakpoint, desc = "DAP Toggle BP", mode = "n" },
				{
					"<leader>B",
					function()
						vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
							if input and input ~= "" then
								dap.set_breakpoint(input)
							else
								dap.set_breakpoint()
							end
						end)
					end,
					desc = "DAP Conditional BP",
					mode = "n",
				},
				{
					"<leader>dr",
					function()
						require("dap").repl.toggle()
					end,
					desc = "DAP REPL",
					mode = "n",
				},
				{
					"<leader>dl",
					function()
						require("dap").run_last()
					end,
					desc = "DAP Run Last",
					mode = "n",
				},
				{
					"<leader>dC",
					function()
						require("dap").run_to_cursor()
					end,
					desc = "DAP Run to cursor",
					mode = "n",
				},
				{
					"<leader>dq",
					function()
						require("dap").terminate()
					end,
					desc = "DAP Terminate",
					mode = "n",
				},
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "DAP UI Toggle",
				mode = "n",
			},
		},
	},
}
