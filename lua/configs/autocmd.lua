local vim = vim
local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

-- remove trailing whitespace
autocmd('BufWritePre', { group = augroup('conf_del_trailing_whitespace'), command = '%s/\\s\\+$//e' })

-- highlight text on yank
autocmd('TextYankPost', {
    group = augroup('conf_highlight_yank'),
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 700 })
    end
})

-- auto balance window on resize
autocmd('VimResized', { group = augroup('conf_window_resizing'), command = 'tabdo wincmd =' })

-- close man and help
autocmd('FileType', {
    group = augroup('conf_close_with_q'),
    pattern = { 'help', 'man', 'lspinfo', 'checkhealth', 'qf', 'query', 'notify' },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<Cmd>Close <CR>', { buffer = event.buf, silent = true })
    end
})

-- auto create dir when saving buffer if not existed yet
autocmd('BufWritePre', {
    group = augroup('conf_auto_make_dir'),
    callback = function(event)
        if event.match:match('^%w%w+://') then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end
})

-- goto last loc when reopen a buffer
autocmd('BufReadPost', {
    group = augroup('conf_goto_last_loc'),
    callback = function(event)
        local exclude = { 'gitcommit', 'NeogitCommitMessage' }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
            return
        end
        vim.b[buf].last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end
})

autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdLineEnter', 'WinLeave' }, {
    group = augroup('conf_auto_redraw_buffer'),
    pattern = '*',
    callback = function()
        if vim.o.nu then
            vim.cmd.redraw()
        end
    end
})

-- disable auto comment on nextline
autocmd('BufEnter', {
    group = augroup('conf_disable_auto_comment'),
    pattern = '*',
    callback = function()
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
    end
})
