local vim = vim

require('telescope').setup({
    defaults = {
        file_ignore_patterns = { '.git', '.cache', 'node_modules' },
        sorting_strategy = 'ascending'
    }
})

-- keymaps
local set = vim.keymap.set
local silent_opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')

set('n', '<Space><CR>', ':Telescope <CR>', silent_opts)
set('n', '<Space>ff', builtin.find_files, silent_opts)
set('n', '<Space>fb', builtin.buffers, silent_opts)
set('n', '<Space>fg', builtin.live_grep, silent_opts)
