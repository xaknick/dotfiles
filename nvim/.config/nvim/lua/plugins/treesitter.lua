return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "c_sharp", "typescript", "nix" },
      sync_install = false,
      autoinstall = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>ss", -- set to `false` to disable one of the mappings
          node_incremental = "<leader>si",
          scope_incremental = "<leader>sc",
          node_decremental = "<leader>sd",
        },
      },
    })
  end,
}
