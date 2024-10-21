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
    })
  end
}

