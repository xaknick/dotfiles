local parsers = {
	"lua",
	"vim",
	"vimdoc",
	"query",
	"yaml",
	"toml",
	"json",
	"javascript",
	"typescript",
	"python",
	"go",
	"rust",
	"c_sharp",
}

local filetypes = {
	"lua",
	"vim",
	"help",
	"query",
	"yaml",
	"toml",
	"json",
	"javascript",
	"typescript",
	"python",
	"go",
	"rust",
	"cs",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup()
			treesitter.install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = filetypes,
				callback = function()
					vim.treesitter.start()
				end,
			})

			vim.keymap.set("n", "<leader>ss", function()
				vim.treesitter.select("parent")
			end, { desc = "Start treesitter selection" })
			vim.keymap.set("x", "<leader>si", function()
				vim.treesitter.select("parent")
			end, { desc = "Expand treesitter selection" })
			vim.keymap.set("x", "<leader>sc", function()
				vim.treesitter.select("parent")
			end, { desc = "Expand treesitter scope" })
			vim.keymap.set("x", "<leader>sd", function()
				vim.treesitter.select("child")
			end, { desc = "Shrink treesitter selection" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		lazy = false,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},
				},
			})

			local select = require("nvim-treesitter-textobjects.select").select_textobject
			local keymaps = {
				["af"] = { "@function.outer", "Select outer function" },
				["if"] = { "@function.inner", "Select inner function" },
				["ac"] = { "@class.outer", "Select outer class" },
				["ic"] = { "@class.inner", "Select inner class" },
				["as"] = { "@local.scope", "Select local scope", "locals" },
			}

			for key, mapping in pairs(keymaps) do
				vim.keymap.set({ "x", "o" }, key, function()
					select(mapping[1], mapping[3])
				end, { desc = mapping[2] })
			end
		end,
	},
}
