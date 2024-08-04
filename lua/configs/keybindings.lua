local vim = vim
local key_map = vim.keymap.set

-- Editor, Buffer, ...
-- configure clipboard, delete
if vim.fn.has('unamedplus')
then
  vim.opt.clipboard = "unnamed,unnamedplus"
  key_map('n', '<leader>d', '"+d', { noremap = true })
  key_map('n', '<leader>D', '"+D', { noremap = true })
  key_map('v', '<leader>d', '"+d', { noremap = true })
else
  vim.opt.clipboard = "unnamed"
  key_map('n', '<leader>d', '"*d', { noremap = true })
  key_map('n', '<leader>D', '"*D', { noremap = true })
  key_map('v', '<leader>d', '"*d', { noremap = true })
end
-- split navigation
key_map('n', '<C-h>', '<C-w>h', { remap = true, desc = 'go to left buffer' })
key_map('n', '<C-j>', '<C-w>j', { remap = true, desc = 'go to down buffer' })
key_map('n', '<C-k>', '<C-w>k', { remap = true, desc = 'go to up buffer' })
key_map('n', '<C-l>', '<C-w>l', { remap = true, desc = 'go to right buffer' })
-- resize panel
key_map('n', '<M-right>', ':vertical resize+1 <CR>')
key_map('n', '<M-left>', ':vertical resize-1 <CR>')
key_map('n', '<M-top>', ':resize+1 <CR>')
key_map('n', '<M-bottom>', ':resize-1 <CR>')
-- clear search filter
key_map('n', '<CR>', ':noh <CR><CR>', { noremap = true, silent = true })
-- diagnostic
local function jump_diagnostic(next, level)
  local jump_to = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  level = level and vim.diagnostic.severity[level] or nil
  return function()
    jump_to({ severity = level })
  end
end
key_map('n', ']d', jump_diagnostic(true), { desc = 'next diagnostic' })
key_map('n', '[d', jump_diagnostic(false), { desc = 'prev diagnostic' })
key_map('n', ']e', jump_diagnostic(true, 'ERROR'), { desc = 'next error diagnostic' })
key_map('n', '[e', jump_diagnostic(false, 'ERROR'), { desc = 'prev error diagnostic' })
key_map('n', ']w', jump_diagnostic(true, 'WARNING'), { desc = 'next warning diagnostic' })
key_map('n', '[w', jump_diagnostic(false, 'WARNING'), { desc = 'prev warning diagnostic' })

-- Coding, LSP
local lsp_buf = vim.lsp.buf
local telescope_builtin = require 'telescope.builtin'

key_map('n', 'gd', lsp_buf.definition, { noremap = true, desc = 'LSP find definition' })
key_map('n', 'gD', lsp_buf.declaration, { noremap = true, desc = 'LSP find declaration' })
key_map('n', 'gr', telescope_builtin.lsp_references, { noremap = true, desc = 'LSP find references' })
key_map('n', 'g]', telescope_builtin.lsp_implementations, { noremap = true, desc = 'LSP find implementations' })
key_map('n', 'td', lsp_buf.type_definition, { noremap = true, desc = 'LSP find type definition' })
key_map('n', 'K', lsp_buf.hover, { noremap = true, desc = 'LSP hover to show documentation' })
key_map('n', '<Space>rn', lsp_buf.rename, { noremap = true, desc = 'LSP rename symbol' })
key_map({ 'n', 'v' }, '<Space>ca', lsp_buf.code_action, { noremap = true, desc = 'LSP code action' })
key_map({ 'n', 'v' }, '<Space>bf', function()
  lsp_buf.format({ async = true })
end, { noremap = true, desc = 'LSP format buffer' })

-- Telescope
key_map('n', '<Space><CR>', ':Telescope <CR>', { noremap = true, desc = 'Open Telescope popup' })
key_map('n', '<Space>ff', telescope_builtin.find_files, { noremap = true, desc = 'Telescope find files' })
key_map('n', '<Space>fb', telescope_builtin.buffers, { noremap = true, desc = 'Telescope buffers' })
key_map('n', '<Space>fg', telescope_builtin.live_grep, { noremap = true, desc = 'Telescope live grep' })

-- DAP
local dap = require('dap')
key_map('n', '<leader>d', '', { desc = '+debug', noremap = true })
key_map('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Dap breakpoint condition: ')) end, {
  desc = 'Dap breakpoint condition',
  noremap = true
})
key_map('n', '<leader>db', function() dap.toggle_breakpoint() end, {
  desc = 'Dap toggle breakpoint',
  noremap = true
})
key_map('n', '<leader>dc', function() dap.continue() end, { desc = 'Dap continue', noremap = true })
key_map('n', '<leader>dC', function() dap.run_to_cursor() end, { desc = 'Dap run to cursor', noremap = true })
key_map('n', '<leader>dg', function() dap.goto_() end, { desc = 'Dap goto line', noremap = true })
key_map('n', '<leader>di', function() dap.step_into() end, { desc = 'Dap step into', noremap = true })
key_map('n', '<leader>do', function() dap.step_out() end, { desc = 'Dap step out', noremap = true })
key_map('n', '<leader>dO', function() dap.step_over() end, { desc = 'Dap step over', noremap = true })
key_map('n', '<leader>dj', function() dap.down() end, { desc = 'Dap down', noremap = true })
key_map('n', '<leader>dk', function() dap.up() end, { desc = 'Dap up', noremap = true })
key_map('n', '<leader>ds', function() dap.session() end, { desc = 'Dap session', noremap = true })
key_map('n', '<leader>dt', function() dap.terminate() end, { desc = 'Dap terminate', noremap = true })
key_map('n', '<leader>dw', function() require('dap.ui.widgets').hover() end,
  { desc = 'Dap widget hover', noremap = true })

-- NERDTree
key_map({ 'n', 'v' }, '<leader>e', ':NERDTreeToggle <CR>', { noremap = true, desc = 'Toogle NERDTree explorer' })
key_map({ 'n', 'v' }, '<leader>f', ':NERDTreeFocus <CR>', { noremap = true, desc = 'Focus NERDTree explorer' })
