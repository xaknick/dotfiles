local M = {}

M.servers = { "gopls" }

function M.setup()
	vim.lsp.config("gopls", {
		settings = {
			gopls = {
				gofumpt = true,
			},
		},
	})
end

return M
