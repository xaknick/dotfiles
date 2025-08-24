local M = {}

M.servers = { "vtsls" }

function M.setup()
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

	-- TypeScript specific keymaps
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
end

return M
