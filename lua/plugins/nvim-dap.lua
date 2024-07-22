local vim = vim
local dap = require('dap')
local dapui = require('dapui')
local dapvt = require('nvim-dap-virtual-text')

-- DAP golang adapter
local dlv_exe = vim.fn.stdpath('data') .. '/mason/packages/delve/dlv'
dap.adapters.delve = {
    type = 'server',
    port = '${port}',
    executable = {
        command = dlv_exe,
        args = { 'dap', '-l', '127.0.0.1:${port}' }
    }
}

-- DAP golang configurations
dap.configurations.go = {
    {
        type = 'delve',
        name = 'Debug',
        request = 'launch',
        program = '${file}'
    },
    {
        type = 'delve',
        name = 'Debug test',
        request = 'launch',
        mode = 'test',
        program = '${file}'
    },
    {
        type = 'delve',
        name = 'Debug test (go.mod)',
        request = 'launch',
        mode = 'test',
        program = './${relativeFileDirname}'
    }
}

-- configure DAP keymaps
local keyset = vim.keymap.set
keyset('n', '<leader>d', '', { desc = '+debug', noremap = true })
keyset('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Dap breakpoint condition: ')) end, {
    desc = 'Dap breakpoint condition',
    noremap = true
})
keyset('n', '<leader>db', function() dap.toggle_breakpoint() end, {
    desc = 'Dap toggle breakpoint',
    noremap = true
})
keyset('n', '<leader>dc', function() dap.continue() end, { desc = 'Dap continue', noremap = true })
keyset('n', '<leader>dC', function() dap.run_to_cursor() end, { desc = 'Dap run to cursor', noremap = true })
keyset('n', '<leader>dg', function() dap.goto_() end, { desc = 'Dap goto line', noremap = true })
keyset('n', '<leader>di', function() dap.step_into() end, { desc = 'Dap step into', noremap = true })
keyset('n', '<leader>do', function() dap.step_out() end, { desc = 'Dap step out', noremap = true })
keyset('n', '<leader>dO', function() dap.step_over() end, { desc = 'Dap step over', noremap = true })
keyset('n', '<leader>dj', function() dap.down() end, { desc = 'Dap down', noremap = true })
keyset('n', '<leader>dk', function() dap.up() end, { desc = 'Dap up', noremap = true })
keyset('n', '<leader>ds', function() dap.session() end, { desc = 'Dap session', noremap = true })
keyset('n', '<leader>dt', function() dap.terminate() end, { desc = 'Dap terminate', noremap = true })
keyset('n', '<leader>dw', function() require('dap.ui.widgets').hover() end, { desc = 'Dap widget hover', noremap = true })


-- configure dapui
dapui.setup({})

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_existed.dapui_config = function()
    dapui.close()
end

vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'blue', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', {
    text = '●',
    texthl = 'blue',
    linehl = 'DapBreakpoint',
    numhl =
    'DapBreakpoint'
})
vim.fn.sign_define('DapBreakpointRejected', {
    text = '●',
    texthl = 'orange',
    linehl = 'DapBreakpoint',
    numhl =
    'DapBreakpoint'
})
vim.fn.sign_define('DapStopped', { text = '●', texthl = 'green', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'yellow', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

-- configure dap virtual text
dapvt.setup({})
