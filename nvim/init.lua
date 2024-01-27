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
        "navarasu/onedark.nvim",
        priority = 1000, -- as the first plugin
        config = function()
            vim.cmd.colorscheme("onedark")
            require("onedark").setup({
                style = "darker",
            })
        end
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
        end
    },

    -- Bufferline
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                   diagnostics = "nvim_lsp",
                },
            })
        end
    },

    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("lualine").setup({
                options = {
                    component_separators = { left = "|", right = "|" },
                },
                extensions = { "nvim-tree" },
                sections = {
                    lualine_c = {},
                    lualine_x = {
                        {
                            "filename",
                            path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
                        }
                    },
                },
            })
        end
    },

    -- Project
    {
        "ahmedkhalf/project.nvim",
        config = function()
            vim.g.nvim_tree_respect_buf_cwd = 1
            --require("") 
            require("project_nvim").setup({
                detection_methods = { "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".sln" },
            })
        end
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    initial_mode = "insert",
                    mappings = require("keybindings").telescopeList,
                },
            })
            require("telescope").load_extension("projects")
        end
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
                ts_config = {
                    lua = { "string", "source" },
                },
                disable_filetype = { "TelescopePrompt", "spectre_panel", "dap-repl", "guihua", "guihua_rust", "clap_input" },
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                    offset = 0, -- Offset from pattern match
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "PmenuSel",
                    highlight_grey = "LineNr",
                },
            })
        end
    },

    -- Indent-blankline
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            require("ibl").setup({
                scope = { enabled = false },
            })
        end
    },

    -- Gitsigns
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },

   -- LSP
   {
       "neovim/nvim-lspconfig",
       dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            'hrsh7th/cmp-nvim-lsp-signature-help',
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
       },
       config = function()
            -- Mason 
            require("mason").setup()

            -- Mason-lspconfig
            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = { "lua_ls", "rust_analyzer", "clangd" },
            })

            -- Lsp keybindings
            local function on_attach(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
                local function buf_set_keymap(...)
                    vim.api.nvim_buf_set_keymap(bufnr, ...)
                end
                require("keybindings").mapLSP(buf_set_keymap)
                -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format { async = true}")
            end

            -- Lua lsp
            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim" },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
                flags = {
                    debounce_text_changes = 160,
                },
                on_attach = on_attach,
           })

           -- Rust lsp
           require("lspconfig").rust_analyzer.setup({
               settings = {
                   ["rust-analyzer"] = {
                       imports = {
                           granularity = {
                               group = "module",
                           },
                           prefix = "self",
                       },
                       cargo = {
                           buildScripts = {
                               enable = true,
                           },
                       },
                       procMacro = {
                           enable = true,
                       },
                   },
               },
               on_attach = on_attach,
           })

           -- Cmp
           local cmp = require("cmp")
           cmp.setup({
        	snippet = {
        		expand = function(args)
        			-- For `vsnip` users.
        			vim.fn["vsnip#anonymous"](args.body)
        		end,
        	},
        	sources = cmp.config.sources(
                {
            		{ name = "nvim_lsp" },
            		-- For vsnip users.
            		{ name = "vsnip" },
            	},
                {
                    { name = "buffer" },
                    { name = "path" }
                }
            ),
            mapping = require("keybindings").cmp(cmp),
           })
       end
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.install").prefer_git = true
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "json",
                    "vim",
                    "lua",
                    "rust",
                    "c",
                    "cpp",
                },
                highlight = { enable = true },
            })
        end
    },
})

require("options")
require("keybindings")
--require("plugins/lsp/setup")
--require("plugins/lsp/cmp")
--require("plugins/lsp/nvim_treesitter")
