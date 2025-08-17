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
				ensure_installed = {
					-- LSP services
					"lua_ls",
					"yamlls",
					"gopls",
					"vtsls",
					"jsonls",
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Formatters (for conform.nvim)
					"stylua",
					"yamlfmt",
					"prettierd",

					-- Linters
					"yamllint",
					"eslint_d",
				},
			})

			-- Extended configuration
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
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						gofumpt = true,
					},
				},
			})

			-- TypeScript (vtsls)
			vim.lsp.config("vtls", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				settings = {
					complete_function_calls = true,
					vtsls = {
						enableMoveToFileCodeAction = true,
						autoUseWorkspaceTsdk = true,
						experimental = {
							maxInlayHintLength = 30,
							completion = {
								enableServerSideFuzzyMatch = true,
							},
						},
					},
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
						inlayHints = {
							enumMemberValues = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							variableTypes = { enabled = false },
						},
					},
				},
			})

			-- Keymap for LSP
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

			-- TypeScript keymaps (LazyVim style)
			vim.keymap.set("n", "gD", function()
				local params = vim.lsp.util.make_position_params(0, "utf-16")
				vim.lsp.buf_request(0, "workspace/executeCommand", {
					command = "typescript.goToSourceDefinition",
					arguments = { params.textDocument.uri, params.position },
				})
			end, { desc = "Goto Source Definition" })

			vim.keymap.set("n", "<leader>co", function()
				require("vtsls").commands["organize_imports"](0)
			end, { desc = "Organize Imports" })

			vim.keymap.set("n", "<leader>cM", function()
				require("vtsls").commands["add_missing_imports"](0)
			end, { desc = "Add missing imports" })

			vim.keymap.set("n", "<leader>cu", function()
				require("vtsls").commands["remove_unused_imports"](0)
			end, { desc = "Remove unused imports" })

			vim.keymap.set("n", "<leader>cD", function()
				require("vtsls").commands["fix_all"](0)
			end, { desc = "Fix all diagnostics" })

			vim.keymap.set("n", "<leader>cV", function()
				vim.lsp.buf_request(0, "workspace/executeCommand", {
					command = "typescript.selectTypeScriptVersion",
				})
			end, { desc = "Select TS workspace version" })
		end,
	},
}
