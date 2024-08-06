local M = {}

function M.load_module(name)
  local ok, module = pcall(require, name)
  if ok == false then
    vim.notify(string.format('config golang dap error for module %s', name))
    return nil
  end
  return module
end

return M
