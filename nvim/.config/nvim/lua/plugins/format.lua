return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = require("languages").get_formatters(),
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "n",
			desc = "Format buffer",
		},
	},
}
