local ts = require 'ftplugins.dap.golang-dap-ts'
local load_module = require 'utils.pcallx'.load_module

local M = {
  last_testname = '',
  last_testpath = '',
  test_buildFlags = '',
  test_verbose = false
}

local default_config = {
  delve = {
    path = vim.fn.stdpath('data') .. '/mason/packages/delve/dlv',
    initialize_timeout_sec = 20,
    port = '${port}',
    args = {},
    build_flags = '',
    detached = vim.fn.has('win32') == 0,
  },
  tests = {
    verbose = false,
  },
}

local internal_global_config = {}

local function get_args()
  return coroutine.create(function(dap_run_co)
    local args = {}
    vim.ui.input({ promt = 'Args: ' }, function(input)
      args = vim.split(input or '', ';')
      coroutine.resume(dap_run_co, args)
    end)
  end)
end

local function get_build_flags(config)
  return coroutine.create(function(dap_run_co)
    local build_flags = config.build_flags
    vim.ui.input({ promt = 'Build flags: ' }, function(input)
      build_flags = vim.split(input or '', ';')
      coroutine.resume(dap_run_co, build_flags)
    end)
  end)
end

local function filter_pick_process()
  local opts = {}
  vim.ui.input(
    { prompt = 'Search by process name (lua pattern) or hit enter to select: ' },
    function(input)
      opts['filter'] = input or ''
    end
  )
  return require 'dap.utils'.pick_process(opts)
end

local function setup_dlv_adatper(dap, config)
  local args = { 'dap', '-l', '127.0.0.1:' .. config.delve.port }
  vim.list_extend(args, config.delve.args)

  local dlv_config = {
    type = 'server',
    port = config.delve.port,
    executable = {
      command = config.delve.path,
      args = args,
      detached = config.delve.detached,
      cwd = config.delve.cwd,
    },
    options = {
      initialize_timeout_sec = config.delve.initialize_timeout_sec,
    },
  }

  dap.adapters.go = function(callback, client_config)
    if client_config.port == nil then
      callback(dlv_config)
      return
    end
    local host = client_config.host
    if host == nil then
      host = '127.0.0.1'
    end
    local listener_addr = host .. ':' .. client_config.port
    dlv_config.port = client_config.port
    dlv_config.executable.args = { 'dap', '-l', listener_addr }
    callback(dlv_config)
  end
end

local function setup_go_configuration(dap, configs)
  local common_debug_configs = {
    {
      type = 'go',
      name = 'Debug',
      request = 'launch',
      program = '${file}',
      buildFlags = configs.delve.build_flags,
    },
    {
      type = 'go',
      name = 'Debug (args)',
      request = 'launch',
      program = '${file}',
      args = get_args,
      buildFlags = configs.delve.build_flags,
    },
    {
      type = 'go',
      name = 'Debug (args & build_flag)',
      request = 'launch',
      program = '${file}',
      args = get_args,
      buildFlags = get_build_flags,
    },
    {
      type = 'go',
      name = 'Debug package',
      request = 'launch',
      program = '${fileDirname}',
      buildFlags = configs.delve.build_flags,
    },
    {
      type = 'go',
      name = 'Attach',
      request = 'attach',
      processId = filter_pick_process,
      buildFlags = configs.delve.build_flags,
    },
    {
      type = 'go',
      name = 'Debug test',
      request = 'launch',
      mode = 'test',
      program = '${file}',
      buildFlags = configs.delve.build_flags,
    },
    {
      type = 'go',
      name = 'Debug test (go.mod)',
      request = 'launch',
      mode = 'test',
      program = './${relativeFileDirname}',
      buildFlags = configs.delve.build_flags,
    },
  }

  if dap.configurations.go == nil then
    dap.configurations.go = {}
  end

  for _, config in ipairs(common_debug_configs) do
    table.insert(dap.configurations.go, config)
  end

  if configs == nil or configs.dap_configurations == nil then
    return
  end

  for _, config in ipairs(configs.dap_configurations) do
    if config.type == 'go' then
      table.insert(dap.configurations.go, config)
    end
  end
end

function M.setup(opts)
  internal_global_config = vim.tbl_deep_extend('force', default_config, opts or {})
  M.test_buildFlags = internal_global_config.delve.build_flags
  M.test_verbose = internal_global_config.tests.verbose

  local dap = load_module('dap')
  setup_dlv_adatper(dap, internal_global_config)
  setup_go_configuration(dap, internal_global_config)
end

local function debug_test(testname, testpath, build_flags, extra_flags)
  local dap = load_module('dap')
  local config = {
    type = 'go',
    name = testname,
    request = 'launch',
    mode = 'test',
    program = testpath,
    args = { '-test.run', '^' .. testname .. '$' },
    buildFlags = build_flags
  }

  if not vim.tbl_isempty(extra_flags) then
    table.move(extra_flags, 1, #extra_flags, #config.args + 1, config.args)
  end

  dap.run(config)
end

function M.debug_test()
  local test = ts.closet_test()
  if test.name == '' or test.name == nil then
    vim.notify('no test found')
    return false
  end

  M.last_testname = test.name
  M.last_testpath = test.package

  local msg = string.format('starting debug session %s : %s ...', test.package, test.name)
  vim.notify(msg)

  local extra_args = {}
  if M.test_verbose then
    extra_args = { '-test.v' }
  end

  debug_test(test.name, test.package, M.test_buildFlags, extra_args)
  return true
end

function M.debug_last_test()
  local testname = M.last_testname
  local testpath = M.last_testpath

  if testname == '' then
    vim.notify('there is no last test found')
    return false
  end

  local msg = string.format('strating debug last session %s : $s ...', testpath, testname)
  vim.notify(msg)

  local extra_args = {}
  if M.test_verbose then
    extra_args = { '-test.v' }
  end

  debug_test(testname, testpath, M.test_buildFlags, extra_args)
  return true
end

function M.get_build_flags()
  return get_build_flags(internal_global_config)
end

function M.get_args()
  return get_args()
end

return M
