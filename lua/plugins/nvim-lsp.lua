local vim = vim

--
-- Auto completion cmp
--
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end
    },
    preselect = cmp.PreselectMode.None,
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer' }
    }, {
        { name = 'buffer' }
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    })
})

--
-- Setup lsp config
--

require('mason').setup({})
local mason_lspconf = require('mason-lspconfig')
mason_lspconf.setup({
    ensure_installed = { 'lua_ls', 'jsonls', 'yamlls', 'clangd' }
})

local lspconf = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconf.lua_ls.setup({ capabilities = capabilities })
lspconf.jsonls.setup({ capabilities = capabilities })
lspconf.yamlls.setup({ capabilities = capabilities })
lspconf.clangd.setup({ capabilities = capabilities })
lspconf.gopls.setup({ capabilities = capabilities })
lspconf.bashls.setup({ capabilities = capabilities })
