local vim = vim
local dap = require('dap')
local dapui = require('dapui')
require('nvim-dap-virtual-text').setup({})

local mason_pkg_dir = vim.fn.stdpath('data') .. '/mason/packages/'

-- DAP golang adapter
local dlv_exe = mason_pkg_dir .. 'delve/dlv'
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
