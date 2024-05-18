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

vim.keymap.set("n", "<C-f>j", "<C-w>j", opt)
vim.keymap.set("n", "<C-f>k", "<C-w>k", opt)
vim.keymap.set("n", "<C-f>h", "<C-w>h", opt)
vim.keymap.set("n", "<C-f>l", "<C-w>l", opt)
vim.keymap.set("n", "<C-f>=", ":vertical resize +5<CR>", opt)
vim.keymap.set("n", "<C-f>-", ":vertical resize -5<CR>", opt)
vim.keymap.set("n", "<C-f>+", ":resize +5<CR>", opt)
vim.keymap.set("n", "<C-f>_", ":resize -5<CR>", opt)

vim.keymap.set("n", "<Leader>w", ":bd!<CR>", opt)
vim.keymap.set("n", "<Leader>e", ":%bd|e#|bd#<CR>", opt)

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
                            base = "#FFFFFF",
                            current_line = "#FFFFFF",
                            inactive_base = "#FFFFFF",
                            tabline = "#FFFFFF",
                            statusline = "#FFFFFF",
                            float = "#FFFFFF",
                        },
                        syntax = {
                            red = "#871094", -- param
                            blue = "#043ABD", -- fn
                            green = "#2b8a06",
                            yellow = "#871094",
                            purple = "#785201", -- key
                            cyan = "#C15200", -- struct
                            orange = "#4F4F4F", -- variable

                            comment = "#9BA0A3",
                        },
                    },
                },
            })
            -- vim.cmd.colorscheme("astrodark")
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
        keys = { -- Example mapping to toggle outline
            { "<Leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        opts = {
            outline_window = {
                win_position = 'left',
                split_command = 'topleft vsplit',
                width = 20,
            },
        },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    preview = false,
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close, -- close on single <esc> press (instead of two)
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
            vim.keymap.set("n", "<C-h>", require("telescope.builtin").buffers)
        end,
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 600,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
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

            -- Cpp
            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- Bash LSP
            local configs = require("lspconfig.configs")
            if not configs.bash_lsp and vim.fn.executable("bash-language-server") == 1 then
                configs.bash_lsp = {
                    default_config = {
                        cmd = { "bash-language-server", "start" },
                        filetypes = { "sh" },
                        root_dir = require("lspconfig").util.find_git_ancestor,
                        init_options = {
                            settings = {
                                args = {},
                            },
                        },
                    },
                }
            end
            if configs.bash_lsp then
                lspconfig.bash_lsp.setup({})
            end

            -- Go
            lspconfig.gopls.setup({
                on_attach = on_attach,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            })

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            --            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
            vim.keymap.set("n", "g[", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "g]", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

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
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)

                    vim.keymap.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>f", function()
                        vim.lsp.buf.format({ async = true })
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
            "hrsh7th/vim-vsnip",
            "hrsh7th/vim-vsnip-integ",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    -- REQUIRED by nvim-cmp. get rid of it once we can
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
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
                    { name = "codeium" },
                }),
                experimental = {
                    -- ghost_text = true,
                },
            })

            -- Enable completing paths in :
            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path" },
                }),
            })
        end,
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        lazy = false,
        ft = { 'rust' },
    },

    -- DAP
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                dependencies = { 'nvim-neotest/nvim-nio' },
            },
            'theHamsta/nvim-dap-virtual-text',
        },

        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            vim.keymap.set('n', '<C-f>b', dap.toggle_breakpoint)
            vim.keymap.set('n', '<C-f>c', dap.continue)
            vim.keymap.set('n', '<C-f>r', dap.repl.open)
            vim.keymap.set('n', '<C-f>u', dap.up)
            vim.keymap.set('n', '<C-f>d', dap.down)
            vim.keymap.set('n', '<C-f>s', dap.terminate)
            vim.keymap.set('n', '<C-n>', dap.step_over)
            vim.keymap.set('n', '<C-s>', dap.step_into)

            dap.adapters.lldb = {
                type = 'executable',
                command = '/opt/homebrew/bin/lldb-vscode',
                name = 'lldb'
            }

            dapui.setup{}
            dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
            dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
            dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
        end,
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
        vim.g.mkdp_filetypes = { "markdown" }
        vim.keymap.set("n", "<Leader>mt", ":MarkdownPreview<CR>", opt)
        vim.keymap.set("n", "<Leader>mp", ":MarkdownPreviewStop<CR>", opt)
      end,
      ft = { "markdown" },
    },
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local bufnr = vim.fn.bufnr('%')
        vim.keymap.set("n", "<CR>", function()
            vim.api.nvim_command([[execute "normal! \<cr>"]])
            vim.api.nvim_command(bufnr .. 'bd')
        end, { buffer = bufnr })
    end,
    pattern = "qf",
})

-- Reopen last Telescope window, super useful for live grep
vim.keymap.set("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>", opts)

vim.g.rustaceanvim = {
    -- LSP configuration
    server = {
        on_attach = function(client, bufnr)
            -- you can also put keymaps in here
            vim.keymap.set("n", "<leader>le", ":RustLsp expandMacro<CR>", opt)
            vim.keymap.set("n", "<leader>lx", ":RustLsp explainError<CR>", opt)
            vim.keymap.set("n", "<leader>lt", ":RustLsp testables<CR>", opt)
            vim.keymap.set("n", "<leader>lr", ":RustLsp runnables<CR>", opt)
            vim.keymap.set("n", "<leader>ld", ":RustLsp debuggables<CR>", opt)
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
