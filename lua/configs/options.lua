local vim = vim
local vopt = vim.opt

-- cursor
vopt.cursorline = true

-- coding
vopt.number = true
vopt.shiftwidth = 2
vopt.shiftround = true
vopt.scrolloff = 5
vopt.sidescrolloff = 5
vopt.lazyredraw = true
vopt.compatible = false

-- indent
vopt.tabstop = 4
vopt.softtabstop = 4
vopt.shiftwidth = 4
vopt.expandtab = true
vopt.smarttab = true
vopt.smartindent = true
vopt.autoindent = true

-- folding
vopt.foldmethod = 'indent'
vopt.foldenable = false

-- mouse
vopt.mouse = 'a'

-- syntax
vopt.ignorecase = true
vim.cmd('syntax on')

-- encoding
vopt.encoding = 'utf-8'
vopt.fileencoding = 'utf-8'

-- disable backup
vopt.backup = false
vopt.wb = false
vopt.swapfile = false

-- colors
vopt.termguicolors = true

-- invisible char
vopt.list = false
local space = "·"
vopt.listchars:append {
    multispace = space,
    lead = space,
    trail = space,
    nbsp = space,
    space = space,
}

-- format options
vopt.formatoptions:remove({ 'o' })
