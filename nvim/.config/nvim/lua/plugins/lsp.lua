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
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- LSP services
					"lua_ls",
					"yamlls",
					"gopls",
					"vtsls",
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Formatters (for conform.nvim)
					"stylua",
					"yamlfmt",

					-- Linters
					"yamllint",
					"eslint_d",
				},
			})

			local lspconfig = require("lspconfig")
			-- Lua
			vim.lsp.config("lua_ls", {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if
							path ~= vim.fn.stdpath("config")
							and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
						then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
							path = {
								"lua/?.lua",
								"lua/?/init.lua",
							},
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
					})
				end,
				settings = { Lua = {} },
			})
			-- Golang
			lspconfig.gopls.setup({
				settings = {
					gopls = {
						gofumpt = true,
					},
				},
			})
			-- Typescript
			lspconfig.vtsls.setup({})
			-- Others
			lspconfig.jsonls.setup({})
			lspconfig.cssls.setup({})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
