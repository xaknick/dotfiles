return {
	"olimorris/codecompanion.nvim",
	branch = "main",
	version = "v19.25.0",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "CodeCompanionChat" },
	keys = {
		{ "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle AI chat" },
	},
	opts = {
		adapters = {
			http = {
				openrouter = function()
					return require("codecompanion.adapters").extend("openrouter", {
						env = {
							api_key = "file:~/.config/secrets/openrouter",
						},
					})
				end,
			},
		},
		interactions = {
			chat = { adapter = "openrouter" },
		},
		display = {
			chat = {
				window = { layout = "float" },
			},
		},
	},
}
