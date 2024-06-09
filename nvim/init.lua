------------------------------ Options ------------------------------
-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit colour
vim.opt.termguicolors = true

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
vim.o.cmdheight = 0

-- Auto reload when edited
vim.o.autoread = true
vim.bo.autoread = true

-- Disable line wrapping
vim.wo.wrap = true

-- When the cursor is at the beginning or end of a line, <Left><Right> can jump to the next line
vim.o.whichwrap = "<,>,[,]"

-- Allow hiding modified buffer
vim.o.hidden = true

-- Mouse support
vim.o.mouse = "a"

-- Forbide creating backup files
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Smaller updatetime
vim.o.updatetime = 300

-- Wait for keyboard shortcut combo time
vim.o.timeoutlen = 10000

-- Split window
vim.o.splitbelow = true
vim.o.splitright = true

-- Format
vim.o.termguicolors = true
vim.opt.termguicolors = true

-- Display of invisible characters, showing only spaces as dots here
vim.o.list = true
vim.opt.listchars = { trail = "~", tab = "▸ ", space = "·" }

-- Enhanced autocomplete
vim.o.wildmenu = true

-- Don't pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. "c"

-- Autocomplete displays up to 10 lines at most
vim.o.pumheight = 10

-- Code folding.
vim.api.nvim_win_set_option(0, "foldmethod", "indent")
vim.api.nvim_win_set_option(0, "foldlevel", 99)
vim.api.nvim_win_set_option(0, "fillchars", "fold: ")

------------------------------ Kyebindings ------------------------------
local opt = { noremap = true, silent = true }

vim.keymap.set("n", "<C-f>", "", opt)

vim.keymap.set("n", "<C-j>", "<C-w>j", opt)
vim.keymap.set("n", "<C-k>", "<C-w>k", opt)
vim.keymap.set("n", "<C-h>", "<C-w>h", opt)
vim.keymap.set("n", "<C-l>", "<C-w>l", opt)
vim.keymap.set("n", "f", "<C-w>w", opt)
vim.keymap.set("n", "<C-f>=", ":vertical resize +15<CR>", opt)
vim.keymap.set("n", "<C-f>-", ":vertical resize -15<CR>", opt)
vim.keymap.set("n", "<C-f>+", ":resize +5<CR>", opt)
vim.keymap.set("n", "<C-f>_", ":resize -5<CR>", opt)
vim.keymap.set("n", "<C-f>w", ":bd!<CR>", opt)
vim.keymap.set("n", "<C-f>e", ":%bd|e#|bd#<CR>", opt)

vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")

-- More same behavior of 'k' and 'j' in wrapped lines
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

vim.keymap.set("n", "gx", ":!open <cWORD><CR>", opt)

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
    -- Layout
    {
        "AstroNvim/astrotheme",
        priority = 1000, -- as the first plugin
        config = function()
            require("astrotheme").setup({
                palettes = {
                    astrodark = {
                        ui = {
                            current_line = "#1A1D23",
                        },
                    },
                    astrolight = {
                        ui = {
                            base = "#ffffff",
                            current_line = "#ffffff",
                            inactive_base = "#ffffff",
                            tabline = "#ffffff",
                            statusline = "#ffffff",
                            float = "#ffffff",
                        },
                        syntax = {
                            red = "#871094", -- param
                            blue = "#043abd", -- fn
                            green = "#179600",
                            purple = "#785201", -- key
                            yellow = "#007369",
                            cyan = "#c15200", -- struct
                            orange = "#4f4f4f", -- variable

                            comment = "#8d9091",
                        },
                    },
                },
            })
            vim.cmd.colorscheme("astrolight")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.install").prefer_git = true
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                highlight = { enable = true },
            })
        end,
    },
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<Leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        opts = {
            outline_window = {
                win_position = 'left',
                split_command = 'topleft vsplit',
                width = 25,
                focus_on_open = false,
                relative_width = false,
            },
            outline_items = {
                show_symbol_details = false,
            },
             keymaps = {
                close = {},
                toggle_preview = 'f',
            },
        },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = '0.1.x',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    preview = false,
                    mappings = {
                        i = {
                            ["<Esc>"] = actions.close, -- close on single <esc> press (instead of two)
                        },
                    },
                },
                pickers = {
                    git_files = {
                        theme = "ivy",
                    },
                    live_grep = {
                        theme = "ivy",
                        preview = true,
                    },
                    buffers = {
                        theme = "ivy",
                        sort_mru = true,
                    },
                },
            })

            vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files)
            vim.keymap.set("n", "<C-g>", require("telescope.builtin").live_grep) -- requires ripgrep
            vim.keymap.set("n", ";", require("telescope.builtin").buffers)
            -- Reopen last Telescope window, super useful for live grep
            vim.keymap.set("n", "<C-n>", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>", opts)
        end,
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 400,
                },
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Setup language servers.
            local lspconfig = require("lspconfig")

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                {border = 'rounded'}
            )

            -- Cpp
            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gl", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    -- None of this semantics tokens business.
                    -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })

            require('lspconfig.ui.windows').default_options.border = 'single'
            vim.diagnostic.config {
                virtual_text = false,
                float = {
                    header = false,
                    border = 'rounded',
                    focusable = true,
                },
            }


        end,
    },
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
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    -- Accept currently selected item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    {
                        name = "nvim_lsp",
                    },
                }, {
                    { name = "path" },
                }),
            })

            -- Enable completing paths in :
            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path" },
                }),
            })

            cmp.setup {
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            }
        end,
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        lazy = false,
        ft = { 'rust' },
        config = function()
            vim.g.rustaceanvim = {
                tools = {
                    float_win_config = {
                        border = 'rounded'
                    },
                    test_executor = 'termopen',
                },
                -- LSP configuration
                server = {
                    on_attach = function(client, bufnr)
                        vim.keymap.set("n", "<leader>lm", ":RustLsp expandMacro<CR>", opt)
                        vim.keymap.set("n", "<leader>lt", ":RustLsp testables<CR>", opt)
                        vim.keymap.set("n", "<leader>le", ":RustLsp explainError<CR>", opt)
                        vim.keymap.set("n", "<leader>lr", ":RustLsp renderDiagnostic<CR>", opt)
                    end,
                    default_settings = {
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
                            checkOnSave = true,
                            check = {
                                enable = true,
                                command = "check",
                                features = "all",
                            }
                        },
                    },
                },
            }
        end
    },

    -- Tools
    {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.bracketed').setup()
            require('mini.pairs').setup()
            require('mini.indentscope').setup({
                draw = { animation = function() return 0 end },
                symbol ='│'
            })
            require('mini.cursorword').setup()
            require('mini.jump2d').setup({
                vim.cmd[[highlight MiniJump2dSpot guifg=#000000 guibg=#f8f8f8 gui=italic,bold]]
            })
            require('mini.files').setup({
                vim.keymap.set("n", "<C-f>f", ":lua MiniFiles.open()<CR>", opt)
            })
        end
    },
    {
        -- Remember last cursor position
        -- https://github.com/neovim/neovim/issues/16339
        'ethanholz/nvim-lastplace',
        config = function()
            require('nvim-lastplace').setup()
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            -- set to 1, the nvim will auto close current preview window when changing
            -- from Markdown buffer to another buffer
            -- default: 1
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_filetypes = { "markdown" }
            vim.keymap.set("n", "<Leader>m", ":MarkdownPreview<CR>", opt)
        end,
        ft = { "markdown" },
    },
})
