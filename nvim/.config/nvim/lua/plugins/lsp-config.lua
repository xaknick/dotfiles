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

      lspconfig.nil_ls.setup({
        settings = {
          ["nil"] = {
            formatting = {
              command = { "nixfmt" }, -- optional, use your formatter if needed
            },
          },
        },
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      local os_utils = require("os_utils")

       -- Skip installation Mason for NixOS 
      if not os_utils.is_nixos() then
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = { "lua_ls" }, -- Add any additional LSPs here
        })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
}
