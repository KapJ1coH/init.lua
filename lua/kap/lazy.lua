-- Lazy stuff
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local imports = {
    'mhartington/formatter.nvim',

    {
        'nvim-telescope/telescope.nvim', version = "0.1.2",
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine-moon')
        end
    },

    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    },

    "stevearc/aerial.nvim",

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
    },
    "lukas-reineke/indent-blankline.nvim",

    ('mhinz/vim-startify'),
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    'ThePrimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',

    'lewis6991/gitsigns.nvim',

    {"chrisgrieser/nvim-early-retirement",},

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'better-defaults',
        dependencies = {
            --- Uncomment these if you want to manage LSP servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},

            {'nanotee/nvim-lsp-basics'},
            {'lukas-reineke/cmp-rg'},

        }
    },
    'tpope/vim-surround',
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    {
        "folke/todo-comments.nvim"
    },

    {
        'fei6409/log-highlight.nvim',
    },

    "folke/neodev.nvim",

    -- testing stuff
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-vim-test",
            "nvim-neotest/neotest-plenary"
        }
    },
    "petertriho/nvim-scrollbar",

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = { "markdown" },
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        name = 'lsp_lines.nvim',
        config = function()
            require("lsp_lines").setup()
            vim.diagnostic.config({
                virtual_text = false,
            })
        end,
    },
}

require('lazy').setup(imports)
