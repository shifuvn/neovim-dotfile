local vim = vim
local mapping = vim.keymap.set

local lsp = vim.lsp
local telescope_builtin = require('telescope.builtin')

-- Coding
-- keymaps for telescope, coding, lsp
mapping('n', '<space><CR>', ':Telescope <CR>', { noremap = true, desc = 'Open Telescope popup' })
mapping('n', '<space>ff', telescope_builtin.find_files, { noremap = true, desc = 'Telescope find files' })
mapping('n', '<space>fb', telescope_builtin.buffers, { noremap = true, desc = 'Telescope find all buffers' })
mapping('n', '<space>fg', telescope_builtin.live_grep, { noremap = true, desc = 'Telescope live_grep' })

mapping('n', 'gd', telescope_builtin.lsp_definitions, { noremap = true, desc = 'Telescope LSP find definition' })
mapping('n', 'gD', lsp.buf.declaration, { noremap = true, desc = 'LSP find declaration' })
mapping('n', 'gr', telescope_builtin.lsp_references, { noremap = true, desc = 'Telescope LSP find references' })
mapping('n', 'K', lsp.buf.hover, { noremap = true, desc = 'LSP hover to show document' })
mapping('n', 'td', lsp.buf.type_definition, { noremap = true, desc = 'LSP find type definition' })
mapping('n', '<space>rn', lsp.buf.rename, { noremap = true, desc = 'LSP rename symbol' })
mapping({ 'n', 'v' }, '<Space>ca', lsp.buf.code_action, { noremap = true, desc = 'LSP open code action' })
mapping({ 'n', 'v' }, '<Space>bf', function()
    lsp.buf.format { async = true }
end, { noremap = true, desc = 'LSP format current buffer' })


-- Editor, Buffer, ...
-- configure clipboard, delete
if vim.fn.has('unamedplus')
then
    vim.opt.clipboard = "unnamed,unnamedplus"
    mapping('n', '<leader>d', '"+d', { noremap = true })
    mapping('n', '<leader>D', '"+D', { noremap = true })
    mapping('v', '<leader>d', '"+d', { noremap = true })
else
    vim.opt.clipboard = "unnamed"
    mapping('n', '<leader>d', '"*d', { noremap = true })
    mapping('n', '<leader>D', '"*D', { noremap = true })
    mapping('v', '<leader>d', '"*d', { noremap = true })
end

-- split navigation
mapping('n', '<C-h>', '<C-w>h', { desc = 'go to left buffer', remap = true })
mapping('n', '<C-j>', '<C-w>j', { desc = 'go to down buffer', remap = true })
mapping('n', '<C-k>', '<C-w>k', { desc = 'go to up buffer', remap = true })
mapping('n', '<C-l>', '<C-w>l', { desc = 'go to right buffer', remap = true })

-- resize panel
mapping('n', '<M-right>', ':vertical resize+1 <CR>')
mapping('n', '<M-left>', ':vertical resize-1 <CR>')
mapping('n', '<M-top>', ':resize+1 <CR>')
mapping('n', '<M-bottom>', ':resize-1 <CR>')

-- clear search filter
mapping('n', '<CR>', ':noh <CR><CR>', { noremap = true, silent = true })

-- diagnostics
local function goto_diagnostic(next, level)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    level = level and vim.diagnostic.severity[level] or nil
    return function()
        go({ severity = level })
    end
end
mapping('n', ']d', goto_diagnostic(true), { desc = 'next diagnostic' })
mapping('n', '[d', goto_diagnostic(false), { desc = 'prev diagnostic' })
mapping('n', ']e', goto_diagnostic(true, 'ERROR'), { desc = 'next error diagnostic' })
mapping('n', '[e', goto_diagnostic(false, 'ERROR'), { desc = 'prev error diagnostic' })
mapping('n', ']w', goto_diagnostic(true, 'WARNING'), { desc = 'next warning diagnostic' })
mapping('n', '[w', goto_diagnostic(false, 'WARNING'), { desc = 'prev warning diagnostic' })

-- switch buffer
mapping('n', '<leader>cb', '<cmd>e #<CR>', { desc = 'switch to other buffer' })


-- NERDTree
mapping('n', '<leader>e', ':NERDTreeToggle <CR>', { desc = 'NERDTree toggle nerdtree explorer', noremap = true })
mapping('n', '<leader>f', ':NERDTreeFocus <CR>', { desc = 'NERDTree focus on nerdtree explorer', noremap = true })

-- DAP
local dap = require('dap')
mapping('n', '<leader>d', '', { desc = '+debug', noremap = true })
mapping('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Dap breakpoint condition: ')) end, {
    desc = 'Dap breakpoint condition',
    noremap = true
})
mapping('n', '<leader>db', function() dap.toggle_breakpoint() end, {
    desc = 'Dap toggle breakpoint',
    noremap = true
})
mapping('n', '<leader>dc', function() dap.continue() end, { desc = 'Dap continue', noremap = true })
mapping('n', '<leader>dC', function() dap.run_to_cursor() end, { desc = 'Dap run to cursor', noremap = true })
mapping('n', '<leader>dg', function() dap.goto_() end, { desc = 'Dap goto line', noremap = true })
mapping('n', '<leader>di', function() dap.step_into() end, { desc = 'Dap step into', noremap = true })
mapping('n', '<leader>do', function() dap.step_out() end, { desc = 'Dap step out', noremap = true })
mapping('n', '<leader>dO', function() dap.step_over() end, { desc = 'Dap step over', noremap = true })
mapping('n', '<leader>dj', function() dap.down() end, { desc = 'Dap down', noremap = true })
mapping('n', '<leader>dk', function() dap.up() end, { desc = 'Dap up', noremap = true })
mapping('n', '<leader>ds', function() dap.session() end, { desc = 'Dap session', noremap = true })
mapping('n', '<leader>dt', function() dap.terminate() end, { desc = 'Dap terminate', noremap = true })
mapping('n', '<leader>dw', function() require('dap.ui.widgets').hover() end, { desc = 'Dap widget hover', noremap = true })


