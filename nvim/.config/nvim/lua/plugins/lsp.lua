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

			-- Keymap for LSP
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

		end,
	},
}
