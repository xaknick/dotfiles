return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local os_utils = require("os_utils")
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      lspconfig.jsonls.setup({});

      if os_utils.is_regular_unix() then
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "lua_ls",
            "yamlls",
          },
        })
        require("mason-tool-installer").setup({
          ensure_installed = {
            "stylua",
            "yamllint",
            "yamlfmt",
          }
        })
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- Install nix lsp for NixOS only
      if os_utils.is_nixos() then
        lspconfig.nil_ls.setup({
          settings = {
            ["nil"] = {
              formatting = {
                command = { "nixfmt" }, -- optional, use your formatter if needed
              },
            },
          },
        })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
}
