local telescope_previewer = require('telescope.previewers')
require('telescope').setup({
    defaults = {
        file_ignore_patterns = { '.git', '.cache', 'node_modules' },
        sorting_strategy = 'ascending',
        shorten_path = true,
        layout_strategy = 'horizontal',
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        previewers = true,
        file_previewer = telescope_previewer.vim_buffer_cat.new,
        grep_previewer = telescope_previewer.vim_buffer_vimgrep.new,
        qflist_previewer = telescope_previewer.vim_buffer_qflist.new,
        buffer_previewer_maker = telescope_previewer.buffer_previewer_maker
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown({})
        }
    }
})
require('telescope').load_extension('ui-select')
