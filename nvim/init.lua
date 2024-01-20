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

    -- Tree
    { "kyazdani42/nvim-tree.lua", event = "VimEnter", dependencies = "nvim-tree/nvim-web-devicons" },
    { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons", "moll/vim-bbye" } },
    { "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
    { "arkav/lualine-lsp-progress" },

    -- Telescope
    { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
    { "LinArcX/telescope-env.nvim" },

    -- Editor
    { "windwp/nvim-autopairs" },
    { "lukas-reineke/indent-blankline.nvim" },
--    { "Pocco81/auto-save.nvim" },

    -- Git
    { "lewis6991/gitsigns.nvim" },

    -- LSP
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "glepnir/lspsaga.nvim", event = "BufRead" },
    { "jose-elias-alvarez/null-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },
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
require('plugins/nvim_tree')
require('plugins/bufferline')
require('plugins/indent_blankline')
require('plugins/autopairs')
require('plugins/gitsigns')
require('plugins/lsp/setup')
require('plugins/lsp/cmp')
require('plugins/lsp/null_lsp')
require('plugins/lsp/saga')
require('plugins/lsp/ui')
require('plugins/lsp/nvim_treesitter')
