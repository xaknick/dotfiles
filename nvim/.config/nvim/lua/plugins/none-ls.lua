return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting
		require("null-ls").setup({
			sources = {
				formatting.stylua,
				formatting.nixfmt,
				formatting.yamlfmt,
				diagnostics.yamllint,
			},
		})

		-- formatting command
		vim.api.nvim_create_user_command("Format", function()
			vim.lsp.buf.format(nil, 10000)
		end, {})

		vim.keymap.set(
			"n",
			"<leader>fm",
			":Format<CR>",
			{ desc = "Format current buffer (also done on save)", noremap = true, silent = true }
		)
	end
}
