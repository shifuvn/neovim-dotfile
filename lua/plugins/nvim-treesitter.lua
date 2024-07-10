require('nvim-treesitter.configs').setup({
    ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'json', 'yaml', 'markdown', 'markdown_inline', 'go' },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true
    },
    additional_vim_regex_highlighting = false
})
