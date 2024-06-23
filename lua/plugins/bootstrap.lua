local vim = vim

vim.cmd [[ packadd packer.nvim ]]

-- startup
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- color, themes
    use {
        'rockyzhang24/arctic.nvim',
        requires = { 'rktjmp/lush.nvim' }
    }
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

    -- syntax, highlight
    use 'nvim-treesitter/nvim-treesitter'

    -- file explorer
    use 'preservim/nerdtree'
    --use 'ryanoasis/vim-devicons'

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- auto completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- autopair
    use 'windwp/nvim-autopairs'

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- indent
    use 'NMAC427/guess-indent.nvim'
end)
