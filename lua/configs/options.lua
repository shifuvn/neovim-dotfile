local vim = vim
local opt = vim.opt

-- editor
opt.cursorline = true
opt.number = true
opt.shiftwidth = 2
opt.shiftround = false
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.lazyredraw = true
opt.compatible = false
opt.smartcase = true
opt.incsearch = true
opt.signcolumn = 'yes'
-- indent
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true
-- folding
opt.foldmethod = 'indent'
opt.foldenable = false
-- mouse
opt.mouse = 'a'

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

opt.list = false
