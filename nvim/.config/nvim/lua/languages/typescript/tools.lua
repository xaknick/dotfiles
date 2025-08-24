local M = {}

M.tools = { "prettierd", "eslint_d" }

M.formatters = {
	javascript = { "prettierd", "prettier", stop_after_first = true },
	typescript = { "prettierd", "prettier", stop_after_first = true },
}

return M
