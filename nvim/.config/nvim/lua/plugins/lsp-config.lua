return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "yamlls",
          "gopls",
        },
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "yamllint",
          "yamlfmt",
        },
      })

      local lspconfig = require("lspconfig")
      -- Lua
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      -- Golang
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            gofumpt = true,
          },
        },
      })
      -- TypeScript
      lspconfig.ts_ls.setup({
        -- Optional: customize filetypes, root_dir, or settings
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
        root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            tsserver = {
              useSyntaxServer = false,
            },
          },
        },
      })
      -- Others
      lspconfig.jsonls.setup({})
      lspconfig.cssls.setup({})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
}
