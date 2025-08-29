local opt = vim.opt
opt.backup = false
opt.swapfile = false
opt.undofile = true

opt.relativenumber = true
opt.number = true

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true

opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.numberwidth = 2

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true
opt.showmode = false
opt.virtualedit = "block"

opt.termguicolors = true

opt.mouse = "a"                    -- Mouse mode "all"
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.whichwrap = "bs<>[]hl"         -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = '→ ', space = '·', trail = '·', nbsp = '␣' }

-- Disable netrw for correct using neotree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
