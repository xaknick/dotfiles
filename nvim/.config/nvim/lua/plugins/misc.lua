return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
        },
        scope = {
          enabled = false,
        },
      })
    end,
  },
  {
    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
  },
  {
    -- Autoclose parentheses, brackets, quotes, etc.
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {},
  },
  {
    -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  -- Comment a line by hotkey
  {
    "numToStr/Comment.nvim",
    opts = {},
    config = function()
      vim.keymap.set("n", "<C-/>", require("Comment.api").toggle.linewise.current, {
        noremap = true,
        silent = true,
        desc = "Toggle comment line"
      })
      vim.keymap.set(
        "v",
        "<C-/>",
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        { noremap = true, silent = true, desc = "Toggle comment selection" }
      )
    end,
  },
  -- Highlight CSS colors
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require('nvim-highlight-colors').setup({})
    end,
  },
  -- Preview definitions in a floating window
  {
    "rmagatti/goto-preview",
    event = "LspAttach",
    opts = {},
    keys = {
      { "gpd", function() require("goto-preview").goto_preview_definition() end, desc = "Preview Definition" },
      { "gpy", function() require("goto-preview").goto_preview_type_definition() end, desc = "Preview Type Definition" },
      { "gpi", function() require("goto-preview").goto_preview_implementation() end, desc = "Preview Implementation" },
      { "gP", function() require("goto-preview").close_all_win() end, desc = "Close All Preview Windows" },
    },
  },
}
