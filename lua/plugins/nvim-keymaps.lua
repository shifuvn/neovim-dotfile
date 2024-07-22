local vim = vim
local keyset = vim.keymap.set
local lsp = vim.lsp

local telescope_builtin = require('telescope.builtin')

-- Coding
-- keymaps for telescope, coding, lsp
keyset('n', '<space><CR>', ':Telescope <CR>', { noremap = true, desc = 'Open Telescope popup' })
keyset('n', '<space>ff', telescope_builtin.find_files, { noremap = true, desc = 'Telescope find files' })
keyset('n', '<space>fb', telescope_builtin.buffers, { noremap = true, desc = 'Telescope find all buffers' })
keyset('n', '<space>fg', telescope_builtin.live_grep, { noremap = true, desc = 'Telescope live_grep' })

keyset('n', 'gd', telescope_builtin.lsp_definitions, { noremap = true, desc = 'Telescope LSP find definition' })
keyset('n', 'gD', lsp.buf.declaration, { noremap = true, desc = 'LSP find declaration' })
keyset('n', 'gr', telescope_builtin.lsp_references, { noremap = true, desc = 'Telescope LSP find references' })
keyset('n', 'K', lsp.buf.hover, { noremap = true, desc = 'LSP hover to show document' })
keyset('n', 'td', lsp.buf.type_definition, { noremap = true, desc = 'LSP find type definition' })
keyset('n', '<space>rn', lsp.buf.rename, { noremap = true, desc = 'LSP rename symbol' })
keyset({ 'n', 'v' }, '<Space>ca', lsp.buf.code_action, { noremap = true, desc = 'LSP open code action' })
keyset({ 'n', 'v' }, '<Space>bf', function()
    lsp.buf.format { async = true }
end, { noremap = true, desc = 'LSP format current buffer' })


-- Editor, Buffer, ...
-- configure clipboard, delete
if vim.fn.has('unamedplus')
then
    vim.opt.clipboard = "unnamed,unnamedplus"
    keyset('n', '<leader>d', '"+d', { noremap = true })
    keyset('n', '<leader>D', '"+D', { noremap = true })
    keyset('v', '<leader>d', '"+d', { noremap = true })
else
    vim.opt.clipboard = "unnamed"
    keyset('n', '<leader>d', '"*d', { noremap = true })
    keyset('n', '<leader>D', '"*D', { noremap = true })
    keyset('v', '<leader>d', '"*d', { noremap = true })
end

-- split navigation
keyset('n', '<C-h>', '<C-w>h', { desc = 'go to left buffer', remap = true })
keyset('n', '<C-j>', '<C-w>j', { desc = 'go to down buffer', remap = true })
keyset('n', '<C-k>', '<C-w>k', { desc = 'go to up buffer', remap = true })
keyset('n', '<C-l>', '<C-w>l', { desc = 'go to right buffer', remap = true })

-- resize panel
keyset('n', '<M-right>', ':vertical resize+1 <CR>')
keyset('n', '<M-left>', ':vertical resize-1 <CR>')
keyset('n', '<M-top>', ':resize+1 <CR>')
keyset('n', '<M-bottom>', ':resize-1 <CR>')

-- clear search filter
keyset('n', '<CR>', ':noh <CR><CR>', { noremap = true, silent = true })

local function goto_diagnostic(next, level)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    level = level and vim.diagnostic.severity[level] or nil
    return function()
        go({ severity = level })
    end
end

keyset('n', ']d', goto_diagnostic(true), { desc = 'next diagnostic' })
keyset('n', '[d', goto_diagnostic(false), { desc = 'prev diagnostic' })
keyset('n', ']e', goto_diagnostic(true, 'ERROR'), { desc = 'next error diagnostic' })
keyset('n', '[e', goto_diagnostic(false, 'ERROR'), { desc = 'prev error diagnostic' })
keyset('n', ']w', goto_diagnostic(true, 'WARNING'), { desc = 'next warning diagnostic' })
keyset('n', '[w', goto_diagnostic(false, 'WARNING'), { desc = 'prev warning diagnostic' })

-- switch buffer
keyset('n', '<leader>cb', '<cmd>e #<CR>', { desc = 'switch to other buffer' })


-- NERDTree
keyset('n', '<leader>e', ':NERDTreeToggle <CR>', { desc = 'toggle nerdtree explorer', noremap = true })
keyset('n', '<leader>f', ':NERDTreeFocus <CR>', { desc = 'focus on nerdtree explorer', noremap = true })
