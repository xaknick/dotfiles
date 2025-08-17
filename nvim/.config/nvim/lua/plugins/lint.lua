return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			yaml = { "yamllint" },
			rust = { "clippy" },
		}

		vim.api.nvim_create_user_command("Lint", function()
			lint.try_lint()
		end, {})

		vim.keymap.set("n", "<leader>cl", "<cmd>Lint<CR>", { desc = "Lint code" })
	end,
}
