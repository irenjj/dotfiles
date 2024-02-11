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

vim.keymap.set("n", "<C-n>", "<C-w>j", opt)
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')

-- More same behavior of 'k' and 'j' in wrapped lines
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr=true})
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr=true})

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
                        ui = {
                            --base = "#282c34",
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
					diagnostics = "nvim_lsp",
				},
			})

			-- Open/close tree
			vim.api.nvim_set_keymap("n", "<C-f>", ":NvimTreeToggle<CR>", opt)
			-- Switch between tabs
			vim.api.nvim_set_keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
			vim.api.nvim_set_keymap("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
			-- Close current tab
			vim.api.nvim_set_keymap("n", "<C-w>", ":bdelete!<CR>", opt)
			vim.api.nvim_set_keymap("n", "<C-e>", ":BufferLineCloseOthers<CR>", opt)
			vim.api.nvim_set_keymap("n", "<C-f>", ":NvimTreeToggle<CR>", opt)
		end,
	},

	-- Lualine
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
					lualine_c = {
                        {
				            "lsp_progress",
                        }
                    },
					lualine_x = {
						{
				            "lsp_progress",
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
			require("telescope").setup({
				defaults = {
					initial_mode = "insert",
					mappings = {
						i = {
							-- Move cursor
							["<Down>"] = "move_selection_next",
							["<Up>"] = "move_selection_previous",
							-- History record
							["<C-n>"] = "cycle_history_next",
							["<C-p>"] = "cycle_history_prev",
							-- Close window
							["<C-c>"] = "close",
						},
					},
				},
			})
			require("telescope").load_extension("projects")
			-- Find file
			vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", opt)
			-- Global search
			vim.api.nvim_set_keymap("n", "<C-g>", ":Telescope live_grep<CR>", opt)
		end,
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
			lspconfig.rust_analyzer.setup {
				-- Server-specific settings. See `:help lspconfig-setup`
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						imports = {
							group = {
								enable = false,
							},
						},
						completion = {
							postfix = {
								enable = false,
							},
						},
                        diagnostics = {
                            enable = true;
                        },
					},
				},
			}

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
			vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
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
--					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
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
			'neovim/nvim-lspconfig',
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
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
					ghost_text = true,
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
	-- inline function signatures
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			-- Get signatures (and _only_ signatures) when in argument lists.
			require "lsp_signature".setup({
				doc_lines = 0,
				handler_opts = {
					border = "none"
				},
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
					"toml",
				},
				highlight = { enable = true },
			})
		end,
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
        'echasnovski/mini.nvim',
        config = function()
            require('mini.bracketed').setup()
            require('mini.comment').setup()
            require('mini.jump2d').setup()
            require('mini.move').setup()
            require('mini.pairs').setup()
            require('mini.surround').setup()
            require('mini.indentscope').setup({
                draw = { animation = function() return 0 end },
                symbol ='│'
            })
            require('mini.misc').setup()
            MiniMisc.setup_auto_root()
            -- TODO try pick and extra
        end
    },
})
