return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
          },
        },
      },
      pickers = {
        live_grep = {
          file_ignore_patterns = { 'node_modules', '.git', '.venv' },
          additional_args = function(_)
            return { "--hidden" }
          end
        },
        find_files = {
          file_ignore_patterns = { 'node_modules', '.git', '.venv' },
          hidden = true
        }

      },
      extensions = {
        "fzf"
      },
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap

    keymap.set('n', '<leader>fb', "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    keymap.set("n", "<leader>fn", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Fuzzy find registers" })
    keymap.set("n", "<leader>ff", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope git_status<cr>", { desc = "Find in git status" })
  end,
}
