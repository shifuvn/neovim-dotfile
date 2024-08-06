local vim = vim
local load_module = require 'utils.pcallx'.load_module

-- Colorscheme
vim.cmd [[colorscheme vscode]]

-- Treesitter
load_module 'nvim-treesitter.configs'.setup({
    ensured_install = { 'c', 'lua', 'vim', 'vimdoc', 'json', 'yaml' },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true
    }
})
