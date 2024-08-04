local vim = vim

local packer_conf = {
    display = {
        open_fn = function()
            return require 'packer.util'.float({ border = 'single' })
        end,
    }
}

require 'packer'.startup({
    function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        -- Load on an autocmd event
        use { 'andymass/vim-matchup', event = 'VimEnter' }

        -- Statusline
        use 'vim-airline/vim-airline'
        use 'vim-airline/vim-airline-themes'

        -- Colorscheme
        use 'Mofiqul/vscode.nvim'
        use 'nvim-treesitter/nvim-treesitter'

        -- File explorer
        use 'preservim/nerdtree'

        -- LSP
        use 'neovim/nvim-lspconfig'
        use 'williamboman/mason.nvim'
        use 'williamboman/mason-lspconfig.nvim'

        -- Autocomplete
        use 'windwp/nvim-autopairs'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-vsnip'
        use 'hrsh7th/vim-vsnip'

        -- Indent
        use 'NMAC427/guess-indent.nvim'
        use 'lukas-reineke/indent-blankline.nvim'

        -- Telescope
        use {
            'nvim-telescope/telescope.nvim',
            requires = { 'nvim-lua/plenary.nvim' }
        }
        use 'nvim-telescope/telescope-dap.nvim'
        use 'nvim-telescope/telescope-ui-select.nvim'

        -- DAP
        use 'mfussenegger/nvim-dap'
        use {
            "rcarriga/nvim-dap-ui",
            requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
        }
        use 'theHamsta/nvim-dap-virtual-text'

        use 'RRethy/vim-illuminate'
    end,
    config = packer_conf
})
