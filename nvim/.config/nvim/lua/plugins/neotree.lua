return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    local keymap = vim.keymap

    keymap.set('n', '<leader>ee', ':Neotree filesystem reveal left<CR>', {})
    keymap.set('n', '<leader>eb', ':Neotree buffers<CR>', {})
    keymap.set('n', '<leader>eg', ':Neotree float git_status<CR>', {})

    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            ".git"
          }
        }
      }
    })
  end
}

