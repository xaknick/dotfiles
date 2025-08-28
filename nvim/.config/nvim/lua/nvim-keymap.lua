vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap
-- Exit insert mode with jk
keymap.set("i", "jk", "<ESC>", { silent = true })

-- Disable the spacebar key's default behavior in Normal and Visual modes
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Keymaps configuration

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true, desc = 'Delete character without copying' })

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', { noremap = true, silent = true, desc = 'Save file' })

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', { noremap = true, silent = true, desc = 'Quit file' })

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', { noremap = true, silent = true, desc = 'Toggle line wrap' })

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true, desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true, desc = 'Indent right' })

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true, desc = 'Paste without losing register' })

vim.keymap.set('n', '<leader>ch', '<cmd>checkhealth<CR>', { noremap = true, silent = true, desc = 'Check health' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Remove unwanted default LSP keymaps globally
for _, lhs in ipairs({ "grr", "gra", "grn", "gri", "grt" }) do
  pcall(vim.keymap.del, "n", lhs)
end
