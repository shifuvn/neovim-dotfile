local M = {}

local lspconf = require 'lspconfig'
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = vim.tbl_deep_extend('force', lsp_capabilities, require 'cmp_nvim_lsp'.default_capabilities())

M.setup = function(ls_name)
  lspconf[ls_name].setup({ capabilities = capabilities })
end

return M
