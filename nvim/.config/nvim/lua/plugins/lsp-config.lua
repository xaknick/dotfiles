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
      -- Others
      lspconfig.jsonls.setup({})
      lspconfig.cssls.setup({})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- Install nix lsp for NixOS only
      -- Ucomment lines below on NixOS
      -- local os_utils = require("os_utils")
      -- if os_utils.is_nixos() then
      --   lspconfig.nil_ls.setup({
      --     settings = {
      --       ["nil"] = {
      --         formatting = {
      --           command = { "nixfmt" }, -- optional, use your formatter if needed
      --         },
      --       },
      --     },
      --   })
      -- elseif os_utils.is_regular_unix() then
      --   require("mason").setup()
      --   require("mason-lspconfig").setup({
      --     ensure_installed = {
      --       "lua_ls",
      --     },
      --   })
      --   require("mason-tool-installer").setup({
      --     ensure_installed = {
      --       "stylua",
      --     },
      --   })
      -- end
    end,
  },
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
}
