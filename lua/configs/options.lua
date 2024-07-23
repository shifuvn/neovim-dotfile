local vim = vim
local opt = vim.opt
local vg = vim.g

--- global
--vg.toggle_theme_icon = "   "

-- editor
opt.cursorline = true
opt.number = true

-- syntax
opt.ignorecase = true
vim.cmd('syntax on')

-- encoding
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- disable backup, swapfile
opt.backup = false
opt.wb = false
opt.swapfile = false

-- ui-colors
opt.termguicolors = true
