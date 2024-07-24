local dap = require 'dap'
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

