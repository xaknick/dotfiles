return {
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({
				extra_groups = {
					"NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
				},
				exclude_groups = {
					"CursorLine",
					"NeoTreeCursorLine",
					"TelescopeSelection",
					"TelescopePreviewLine",
					"TelescopePreviewMatch",
					"TelescopeSelectionCaret",
					"TelescopeResultsDiffAdd",
					"TelescopeResultsDiffDelete",
					"TelescopeResultsDiffChange",
				},
			})
			require("transparent").clear_prefix("NeoTree")
			require("transparent").clear_prefix("Telescope")

			vim.keymap.set(
				"n",
				"<leader>tt",
				":TransparentToggle<CR>",
				{ desc = "Toggle transparency", noremap = true, silent = true }
			)
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
}
