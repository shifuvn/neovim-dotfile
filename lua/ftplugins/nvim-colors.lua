local vim = vim

-- Colorscheme
vim.cmd [[colorscheme vscode]]

-- Treesitter
require 'nvim-treesitter.configs'.setup({
    ensured_install = { 'c', 'lua', 'vim', 'vimdoc', 'json', 'yaml' },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true
    }
})
