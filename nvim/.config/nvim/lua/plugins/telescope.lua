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
    local open_with_trouble = require("trouble.sources.telescope").open

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<c-t>"] = open_with_trouble,               -- open with trouble
          },
          n = {
            ["<c-t>"] = open_with_trouble,
          },
        },
      },
      pickers = {
        live_grep = {
          file_ignore_patterns = { "node_modules", ".git", ".venv" },
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
        find_files = {
          file_ignore_patterns = { "node_modules", ".git", ".venv" },
          hidden = true,
        },
      },
      extensions = {
        "fzf",
      },
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap
    local builtin = require("telescope.builtin")
    keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
    keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", builtin.registers, { desc = "Fuzzy find registers" })
    keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Find in git status" })
    keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
  end,
}
