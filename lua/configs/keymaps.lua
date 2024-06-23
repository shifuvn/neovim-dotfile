local vim = vim
local set = vim.keymap.set

-- configure clipboard, delete
if vim.fn.has('unamedplus')
then
    vim.opt.clipboard = "unnamed,unnamedplus"
    set('n', '<leader>d', '"+d', { noremap = true })
    set('n', '<leader>D', '"+D', { noremap = true })
    set('v', '<leader>d', '"+d', { noremap = true })
else
    vim.opt.clipboard = "unnamed"
    set('n', '<leader>d', '"*d', { noremap = true })
    set('n', '<leader>D', '"*D', { noremap = true })
    set('v', '<leader>d', '"*d', { noremap = true })
end

-- split navigation
set('n', '<C-h>', '<C-w>h', { desc = 'go to left buffer', remap = true })
set('n', '<C-j>', '<C-w>j', { desc = 'go to down buffer', remap = true })
set('n', '<C-k>', '<C-w>k', { desc = 'go to up buffer', remap = true })
set('n', '<C-l>', '<C-w>l', { desc = 'go to right buffer', remap = true })

-- resize panel
set('n', '<M-right>', ':vertical resize+1 <CR>')
set('n', '<M-left>', ':vertical resize-1 <CR>')
set('n', '<M-top>', ':resize+1 <CR>')
set('n', '<M-bottom>', ':resize-1 <CR>')

-- clear search filter
set('n', '<CR>', ':noh <CR><CR>', { noremap = true, silent = true })

local function goto_diagnostic(next, level)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    level = level and vim.diagnostic.severity[level] or nil
    return function()
        go({ severity = level })
    end
end

set('n', ']d', goto_diagnostic(true), { desc = 'next diagnostic' })
set('n', '[d', goto_diagnostic(false), { desc = 'prev diagnostic' })
set('n', ']e', goto_diagnostic(true, 'ERROR'), { desc = 'next error diagnostic' })
set('n', '[e', goto_diagnostic(false, 'ERROR'), { desc = 'prev error diagnostic' })
set('n', ']w', goto_diagnostic(true, 'WARNING'), { desc = 'next warning diagnostic' })
set('n', '[w', goto_diagnostic(false, 'WARNING'), { desc = 'prev warning diagnostic' })

-- switch buffer
set('n', '<leader>cb', '<cmd>e #<CR>', { desc = 'switch to other buffer' })
