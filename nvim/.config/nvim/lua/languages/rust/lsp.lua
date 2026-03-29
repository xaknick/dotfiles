local M = {}

M.servers = { "rust_analyzer" }

function M.setup()
	vim.lsp.config("rust_analyzer", {
		settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true,
				},
				check = {
					command = "clippy",
				},
				imports = {
					granularity = {
						group = "module",
					},
					prefix = "self",
				},
				completion = {
					autoimport = {
						enable = true,
					},
				},
				diagnostics = {
					enable = true,
				},
			},
		},
	})
end

return M
