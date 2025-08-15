return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint" },
			typescript = { "eslint" },
			yaml = { "yamllint" },
		}

		vim.api.nvim_create_user_command("Lint", function()
			lint.try_lint()
		end, {})

		vim.keymap.set("n", "<leader>ll", "<cmd>Lint<CR>", { desc = "Lint code" })
	end,
}
