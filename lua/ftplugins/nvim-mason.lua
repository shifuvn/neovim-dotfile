require'mason'.setup({})
local mason_conf = require'mason-lspconfig'
mason_conf.setup({
	ensure_installed = {'lua_ls', 'jsonls', 'yamlls', 'clangd'}
})
