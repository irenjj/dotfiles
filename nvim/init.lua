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
vim.wo.cursorline = false

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

-- Line wrapping
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
-- vim.api.nvim_win_set_option(0, "foldmethod", "indent")
-- vim.api.nvim_win_set_option(0, "foldlevel", 99)
-- vim.api.nvim_win_set_option(0, "fillchars", "fold: ")
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99
-- vim.o.foldcolumn = '1'

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block-Cursor,r-cr-o:hor20"
vim.cmd [[
  augroup CursorColor
    autocmd!
    autocmd InsertEnter * highlight Cursor gui=NONE guifg=white guibg=green
    autocmd InsertLeave * highlight Cursor gui=NONE guifg=NONE guibg=NONE
  augroup END
]]

vim.api.nvim_create_augroup('IrreplaceableWindows', { clear = true })
vim.api.nvim_create_autocmd('BufWinEnter', {
    group = 'IrreplaceableWindows',
    pattern = '*',
    callback = function()
        local filetypes = { 'git', 'qf', 'aerial' }
        local buftypes = { 'nofile', 'terminal', 'quickfix' }
        if vim.tbl_contains(buftypes, vim.bo.buftype) and vim.tbl_contains(filetypes, vim.bo.filetype) then
            vim.cmd 'set winfixbuf'
        end
    end,
})

------------------------------ Kyebindings ------------------------------
local opt = { noremap = true, silent = true }

vim.keymap.set("n", "<C-f>", "", opt)
vim.keymap.set("n", "<C-=>", "", opt)
vim.keymap.set("n", "<C-->", "", opt)

vim.keymap.set("n", "<C-j>", "<C-w>j", opt)
vim.keymap.set("n", "<C-k>", "<C-w>k", opt)
vim.keymap.set("n", "<C-h>", "<C-w>h", opt)
vim.keymap.set("n", "<C-l>", "<C-w>l", opt)
vim.keymap.set("n", "<C-r>", "<C-w>r", opt)
vim.keymap.set("n", "<leader>w", ":bd!<CR>", opt)
vim.keymap.set("n", "<leader>e", ":%bd|e#|bd#<CR>", opt)
vim.keymap.set("n", "<C-=>", ":vertical resize +5<CR>", opt)
vim.keymap.set("n", "<C-->", ":resize +5<CR>", opt)

vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")

-- More same behavior of 'k' and 'j' in wrapped lines
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

vim.keymap.set("n", "gx", ":!open <cWORD><CR>", opt)

-- Un-highlight last search result
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<CR>')

-- Wrap or unwrap line
vim.keymap.set('n', '<leader>tw', ':set wrap!<CR>')

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
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("tokyonight").setup({
                on_highlights = function(h, _)
                    h["@variable.builtin"] = { fg = "#e0af68" }
                    h["@variable.member"] = { fg = "#ff757f" }
                    h["@variable.parameter"] = { fg = "#c8d3f5" }
                end,
            })
            vim.cmd.colorscheme("tokyonight-night")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.install").prefer_git = true
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                highlight = { enable = true },
                    fold = { enable = true },
            })
        end,
    },
    {
        'stevearc/aerial.nvim',
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            layout = {
                default_direction = "float",
                min_width = { 0.8 },
            },
            float = {
                relative = "win",
            },
        },
        vim.keymap.set("n", "<leader>o", ":AerialToggle<CR>")
    },
    -- Lsp status
    {
        "j-hui/fidget.nvim",
        opts = {
            vim.keymap.set("n", "<leader>cl", ":Fidget clear<CR>", opt)
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

            vim.keymap.set("n", "<C-f>", require("telescope.builtin").git_files)
            vim.keymap.set("n", "<C-g>", require("telescope.builtin").live_grep) -- requires ripgrep
            vim.keymap.set("n", "f", require("telescope.builtin").buffers)
            -- Reopen last Telescope window, super useful for live grep
            vim.keymap.set("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>", opts)
        end,
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                current_line_blame = false,
                current_line_blame_opts = { delay = 100 },

                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({']c', bang = true})
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end)

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({'[c', bang = true})
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end)

                    -- Actions
                    map('n', '<leader>hs', gitsigns.stage_hunk)
                    map('n', '<leader>hr', gitsigns.reset_hunk)
                    map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                    map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                    map('n', '<leader>hS', gitsigns.stage_buffer)
                    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
                    map('n', '<leader>hR', gitsigns.reset_buffer)
                    map('n', '<leader>hp', gitsigns.preview_hunk)
                    map('n', '<leader>hd', gitsigns.diffthis)
                    map('n', '<leader>hD', function() gitsigns.diffthis('~') end)

                    map('n', '<leader>td', gitsigns.toggle_deleted)
                    map('n', '<leader>tc', gitsigns.toggle_current_line_blame)

                    -- Text object
                    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
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
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = 'rounded' }
            )

            -- vim.lsp.inlay_hint.enable()
            local function toggle_inlay_hints()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end
            vim.keymap.set("n", "<leader>i", toggle_inlay_hints)

            -- Cpp
            lspconfig.clangd.setup({
                on_attach = on_attach,
                filetypes = { "h", "c", "cpp", "tpp", "cc", "objc", "objcpp"},
                capabilities = capabilities,
            })
            vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
                pattern = {"*.tpp"},
                command = "set filetype=cpp"
            })

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
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    -- vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev)
                    -- vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next)
                    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>lf', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    -- None of this semantics tokens business.
                    -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })
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
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require('lspkind')
            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        with_text = true, -- do not show text alongside icons
                        maxwidth = 30,
                        before = function(entry, vim_item)
                            local m = vim_item.menu and vim_item.menu or ""
                            if #m > 30 then
                                vim_item.menu = string.sub(m, 1, 20) .. "..."
                            end
                            return vim_item
                        end,
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    -- Accept currently selected item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources{
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "copilot" },
                },
                experimental = {
                    ghost_text = true,
                },
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
                        vim.keymap.set("n", "<leader>le", ":RustLsp renderDiagnostic<CR>", opt)
                        vim.keymap.set("n", "<leader>ld", ":RustLsp debuggables<CR>", opt)
                        vim.keymap.set("n", "<leader>lp", ":RustLsp parentModule<CR>", opt)
                        vim.keymap.set("n", "<leader>lk", ":RustLsp flyCheck<CR>", opt)
                        vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist)
                        vim.keymap.set("n", "<leader>lb", ":Cargo build<CR>", opt)
                        vim.keymap.set("n", "<leader>lr", ":RustAnalyzer restart<CR>", opt)
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
                            checkOnSave = false,
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
            -- require('mini.pairs').setup()
            require('mini.indentscope').setup({
                draw = { animation = function() return 0 end },
                symbol ='│'
            })
            require('mini.jump2d').setup()
            require('mini.files').setup({
                vim.keymap.set("n", "<leader>f", ":lua MiniFiles.open()<CR>", opt)
            })
            require('mini.icons').setup()
            require('mini.misc').setup()
            MiniMisc.setup_auto_root()
        end
    },
    {
        'RRethy/vim-illuminate',
        config = function()
            require('illuminate').configure()
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
            vim.keymap.set("n", "<Leader>tm", ":MarkdownPreview<CR>", opt)
        end,
        ft = { "markdown" },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    },
    {
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        config = function () require("copilot_cmp").setup() end,
        dependencies = {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            config = function()
                require("copilot").setup({
                    suggestion = { enabled = false },
                    panel = { enabled = false },
                })
            end,
        },
    },
    {
        "pteroctopus/faster.nvim",
        config = function()
            require('faster').setup()
        end
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<C-;>]],
                direction = 'float',
                float_opts = {
                    width = function()
                        return math.floor(vim.o.columns * 0.98)
                    end,
                    height = function()
                        return math.floor(vim.o.lines * 0.95)
                    end,
                },
            })
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
})
