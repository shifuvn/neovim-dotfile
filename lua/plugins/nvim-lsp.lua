local vim = vim

require('mason').setup({})
local mason_lspconf = require('mason-lspconfig')
mason_lspconf.setup({
    ensure_installed = { 'lua_ls', 'jsonls', 'yamlls' }
})

local lspconf = require('lspconfig')
lspconf.lua_ls.setup({})
lspconf.jsonls.setup({})
lspconf.yamlls.setup({})
lspconf.clangd.setup({})

-- LspAttach autocmd keymap
local lsp = vim.lsp
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user_lsp_attach_autocmd', {}),
    callback = function(event)
        vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local opts = { buffer = event.buf }
        local set = vim.keymap.set

        set('n', 'gd', lsp.buf.definition, opts)
        set('n', 'gD', lsp.buf.declaration, opts)
        set('n', 'K', lsp.buf.hover, opts)
        set('n', 'td', lsp.buf.type_definition, opts)
        set('n', '<Space>rn', lsp.buf.rename, opts)
        set({ 'n', 'v' }, '<Space>ca', lsp.buf.code_action, opts)
        set({ 'n', 'v' }, '<Space>bf', function()
            lsp.buf.format { async = true }
        end, opts)
    end
})
