return {
	{
		"folke/neodev.nvim",
		opts = {},
		config = function()
			require("neodev").setup({
				library = { types = true, lsp = { "lua_ls" } },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"yioneko/nvim-vtsls", -- For TypeScript
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = require("languages").get_lsp_servers(),
			})
			require("mason-tool-installer").setup({
				ensure_installed = require("languages").get_tools(),
			})

			-- Load language-specific configurations
			require("languages").load_lsp_configs()

			-- Buffer-local LSP keymaps on attach (conflict-safe & community-friendly)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
				callback = function(ev)
					local buf = ev.buf
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
					end

					-- Implementation: use 'gri' (avoid clobbering native Vim 'gi')
					map("n", "gri", vim.lsp.buf.implementation, "LSP: Go to Implementation")
					map("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")
					map("n", "gD", vim.lsp.buf.declaration, "LSP: Go to Declaration")
					map("n", "gy", vim.lsp.buf.type_definition, "LSP: Go to Type Definition")
					map("n", "gk", vim.lsp.buf.signature_help, "LSP: Signature Help")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
					map({ "n", "v" }, "<leader>cr", vim.lsp.buf.rename, "LSP: Rename")
					map("n", "gl", vim.diagnostic.open_float, "Diagnostics: Line Float")
					-- Keep Neovim defaults for ]d / [d navigation
				end,
			})
		end,
	},
}
