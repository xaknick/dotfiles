return {
  {
    "neovim/nvim-lspconfig",
    config = function()
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

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      local os_utils = require("os_utils")

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

      -- Skip installation Mason for NixOS
      if not os_utils.is_nixos() then
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = { "lua_ls", "ansiblels", "yamlls" }, -- Add any additional LSPs here
        })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
}
