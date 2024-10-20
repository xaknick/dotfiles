local opt = vim.opt
opt.backup = false
opt.swapfile = false

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

opt.termguicolors = true

opt.mouse = 'a' -- Mouse mode "all"
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.whichwrap = 'bs<>[]hl' -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')

-- Keymaps
vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

