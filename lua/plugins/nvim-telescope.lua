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

set('n', '<space><CR>', ':Telescope <CR>', silent_opts)
set('n', '<space>ff', builtin.find_files, silent_opts)
set('n', '<space>fb', builtin.buffers, silent_opts)
set('n', '<space>fg', builtin.live_grep, silent_opts)
