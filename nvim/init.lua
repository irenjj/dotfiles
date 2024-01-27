local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Theme
    {'navarasu/onedark.nvim'},

    -- Nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        event = "VimEnter",
    },

    -- Bufferline
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons", "moll/vim-bbye" },
    },

    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
    },

    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { "ahmedkhalf/project.nvim" },

    -- Git
    { "lewis6991/gitsigns.nvim" },

    -- LSP
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/vim-vsnip" },
    { "onsails/lspkind-nvim" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "mortepau/codicons.nvim" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
})

require("nvim-treesitter.install").prefer_git = true

require('options')
require('keybindings')
require('colorscheme')
require('plugins/tree')
require('plugins/bufferline')
require('plugins/autopairs')
require('plugins/indent_blankline')
require('plugins/project')
require('plugins/lualine')
require('plugins/gitsigns')
require('plugins/lsp/setup')
require('plugins/lsp/cmp')
require('plugins/lsp/nvim_treesitter')
