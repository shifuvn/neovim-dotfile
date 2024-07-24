local M = {}

local lspconf = require'lspconfig'
local lsp_capabilities = require'cmp_nvim_lsp'.default_capabilities()

M.setup = function(ls_name)
  lspconf[ls_name].setup({ capabilities = lsp_capabilities })
end

return M
