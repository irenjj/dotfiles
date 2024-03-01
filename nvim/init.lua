------------------------------ Options ------------------------------
-- Rebind leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- System clipboard
vim.o.clipboard = "unnamed"

-- Utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

-- Line number
vim.wo.number = true

-- Highlight current line
vim.wo.cursorline = true

-- Tab
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true

-- Replace tab with space
vim.o.expandtab = true
vim.bo.expandtab = true

-- Shift width
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4

-- Align
vim.o.autoindent = true
vim.bo.autoindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartindent = true
vim.o.incsearch = true

vim.wo.signcolumn = "yes"

-- Command height
vim.o.cmdheight = 2

-- Auto reload when edited
vim.o.autoread = true
vim.bo.autoread = true

--Disable line wrapping
vim.wo.wrap = true

-- When the cursor is at the beginning or end of a line, <Left><Right> can jump to the next line
vim.o.whichwrap = "<,>,[,]"

-- Allow hiding modified buffer
vim.o.hidden = true

-- Mouse support
vim.o.mouse = "a"

-- forbide creating backup files
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- smaller updatetime
vim.o.updatetime = 300

-- Wait for keyboard shortcut combo time
-- vim.o.timeoutlen = 500

-- split window
vim.o.splitbelow = true
vim.o.splitright = true

-- Autocomplete does not auto-select
-- vim.g.completeopt = "menu,menuone,noselect,noinsert"

-- format
vim.o.termguicolors = true
vim.opt.termguicolors = true

-- Display of invisible characters, showing only spaces as dots here
vim.o.list = true
vim.opt.listchars = {trail = '~', tab = '▸ ', space = '·'}

-- Enhanced autocomplete
vim.o.wildmenu = true

-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. "c"

-- Autocomplete displays up to 10 lines at most
vim.o.pumheight = 10

-- Always display the tabline
vim.o.showtabline = 2

------------------------------ Kyebindings ------------------------------
local opt = { noremap = true, silent = true }

vim.keymap.set("n", "<C-f>", "", opt)

vim.keymap.set("n", "<C-f>j", "<C-w>j", opt)
vim.keymap.set("n", "<C-f>k", "<C-w>k", opt)
vim.keymap.set("n", "<C-f>h", "<C-w>h", opt)
vim.keymap.set("n", "<C-f>l", "<C-w>l", opt)
vim.keymap.set("n", "<C-f>=", ":vertical resize +5<CR>", opt)
vim.keymap.set("n", "<C-f>-", ":vertical resize -5<CR>", opt)
vim.keymap.set("n", "<C-f>+", ":resize +5<CR>", opt)
vim.keymap.set("n", "<C-f>_", ":resize -5<CR>", opt)

vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')

-- More same behavior of 'k' and 'j' in wrapped lines
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr=true})
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr=true})

vim.keymap.set("n", "<leader>s", ":LspRestart<CR>", opt)
vim.keymap.set("n", "<leader>w", ":wall<CR>", opt)

vim.keymap.set("n", "<leader>p", ":echo expand('%:p')<CR>", opt)

vim.keymap.set("n", "<leader>le", ":RustLsp expandMacro<CR>", opt)
vim.keymap.set("n", "<leader>lo", ":RustLsp openCargo<CR>", opt)
vim.keymap.set("n", "<leader>lt", ":RustLsp syntaxTree<CR>", opt)

------------------------------ Plugins ------------------------------
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
    -- Colorscheme
    {
        "AstroNvim/astrotheme",
        priority = 1000, -- as the first plugin
        config = function()
            require("astrotheme").setup({
                palettes = {
                    astrodark = {
                        syntax = {
                            --text = "#a7a9c2",
                            comment = "#7b7f8c",
                        },
                        ui = {
                            selection = "#404959",
                            menu_selection = "#404959",

                            base = "#282c34",
                            tabline = "#282c34",
                            statusline = "#282c34",
                            tool = "#282c34",
                            current_line = "#282c34",

                            split = "#323842",
                            inactive_base = "#323842",

                            float = "#262930",

                            none_text = "#51556e",
                        }
                    }
                }
            })
            vim.cmd.colorscheme("astrodark")
        end,
    },

    -- Nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        event = "VimEnter",
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                actions = {
                    open_file = {
                        resize_window = true,
                        quit_on_open = true,
                    },
                },
            })
        end,
    },

    -- Bufferline
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
--                    diagnostics = "nvim_lsp",
                },
            })

            -- Open/close tree
            vim.api.nvim_set_keymap("n", "<C-f>f", ":NvimTreeToggle<CR>", opt)
            -- Switch between tabs
            vim.api.nvim_set_keymap("n", "<C-f>i", ":BufferLineCyclePrev<CR>", opt)
            vim.api.nvim_set_keymap("n", "<C-f>o", ":BufferLineCycleNext<CR>", opt)
            -- Close current tab
            vim.api.nvim_set_keymap("n", "<C-f>w", ":bdelete!<CR>", opt)
            vim.api.nvim_set_keymap("n", "<C-f>e", ":BufferLineCloseOthers<CR>", opt)
        end,
    },

    -- Lualine
    {
        'arkav/lualine-lsp-progress',
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("lualine").setup({
                options = {
                      theme = "auto",
                    component_separators = { left = "|", right = "|" },
                },
                extensions = { "nvim-tree" },
                sections = {
                    lualine_c = { 'lsp_progress' },
                    lualine_x = {
                        {
--                            "filename",
--                            path = 1,
                        },
                    },
                },
            })
        end,
    },

    -- Project
    {
        "ahmedkhalf/project.nvim",
        config = function()
            vim.g.nvim_tree_respect_buf_cwd = 1
            require("project_nvim").setup({
                detection_methods = { "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".sln" },
            })
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local actions = require('telescope.actions')
            require 'telescope'.setup({
              defaults = {
                preview = false,
                mappings = {
                  i = {
                    ['<esc>'] = actions.close, -- close on single <esc> press (instead of two)
                  },
                },
              },
              pickers = {
                git_files = {
                  theme = 'ivy',
                },
                buffers = {
                  theme = 'ivy',
                  sort_mru = true,
                },
                live_grep = {
                  theme = 'ivy',
                  preview = true
                }
              },
            })
            -- Find file
            vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", opt)
            -- Global search
            vim.api.nvim_set_keymap("n", "<C-g>", ":Telescope live_grep<CR>", opt)

            require("telescope").load_extension("projects")
        end
    },

    -- Gitsigns
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
            opts = {
                inlay_hints = { enable = true },
            },
        config = function()
            -- Setup language servers.
            local lspconfig = require('lspconfig')

            -- Rust
--            lspconfig.rust_analyzer.setup {
--                -- Server-specific settings. See `:help lspconfig-setup`
--                settings = {
--                    ["rust-analyzer"] = {
--                        cargo = {
--                            allFeatures = true,
--                        },
--                        diagnostics = {
--                            enable = true;
--                        },
--                        checkOnSave = true,
--                        check = {
--                            enable = true,
--                            command = "check",
--                            features = "all",
--                         },
--                    },
--                },
--            }

            -- Bash LSP
            local configs = require 'lspconfig.configs'
            if not configs.bash_lsp and vim.fn.executable('bash-language-server') == 1 then
                configs.bash_lsp = {
                    default_config = {
                        cmd = { 'bash-language-server', 'start' },
                        filetypes = { 'sh' },
                        root_dir = require('lspconfig').util.find_git_ancestor,
                        init_options = {
                            settings = {
                                args = {}
                            }
                        }
                    }
                }
            end
            if configs.bash_lsp then
                lspconfig.bash_lsp.setup {}
            end

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
--            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
            vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev)
            vim.keymap.set('n', 'g]', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
--                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--                    vim.keymap.set('n', '<leader>wl', function()
--                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--                    end, opts)
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)

                    vim.keymap.set({ 'n', 'v' }, '<leader>.', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    -- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
                    -- *and* there's some way to make it only apply to the current line.
                    -- if client.server_capabilities.inlayHintProvider then
                    --     vim.lsp.inlay_hint(ev.buf, true)
                    -- end

                    -- None of this semantics tokens business.
                    -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })
        end
    },

    -- LSP-based code-completion
    {
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/vim-vsnip",
            "hrsh7th/vim-vsnip-integ",
        },
        config = function()
            local cmp = require'cmp'
            cmp.setup({
                snippet = {
                    -- REQUIRED by nvim-cmp. get rid of it once we can
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    -- Accept currently selected item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                }, {
                    { name = 'path' },
                }),
                experimental = {
                    -- ghost_text = true,
                },
            })

            -- Enable completing paths in :
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' }
                })
            })
        end
    },

    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.install").prefer_git = true
            require("nvim-treesitter.configs").setup({
                ensure_installed = 'all',
                highlight = { enable = true },
            })
        end,
    },

    {
        'echasnovski/mini.nvim',
        config = function()
            -- require('mini.bracketed').setup()
--            require('mini.comment').setup()
            require('mini.jump2d').setup()
            -- require('mini.move').setup()
            require('mini.pairs').setup()
            -- require('mini.surround').setup()
            require('mini.indentscope').setup({
                draw = { animation = function() return 0 end },
                symbol ='│'
            })
            require('mini.cursorword').setup()
        end
    },

    {
        "FabijanZulj/blame.nvim",
        config = function()
            require('blame').setup()
            vim.api.nvim_set_keymap("n", "<leader>b", ":ToggleBlame window<CR>", opt)
            vim.api.nvim_set_keymap("n", "<leader>c", ":DisableBlame<CR>", opt)
        end
    },
})

-- Reopen last Telescope window, super useful for live grep
vim.keymap.set("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>", opts)

vim.g.rustaceanvim = {
    -- LSP configuration
    server = {
        on_attach = function(client, bufnr)
          -- you can also put keymaps in here
        end,
        default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
                cargo = {
                    allFeatures = true,
                },
                completion = {
                    postfix = {
                        enable = false,
                    },
                },
                diagnostics = {
                    enable = true;
                },
                checkOnSave = {
                    enable = true,
                    command = "check",
                }
            },
        },
    },
}
