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
-- vim.o.backup = false
-- vim.o.writebackup = false
-- vim.o.swapfile = false

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
vim.o.list = false
vim.o.listchars = "space:·,tab:>-"

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

vim.keymap.set("n", "<C-j>", "<C-w>j", opt)
vim.keymap.set("n", "<C-k>", "<C-w>k", opt)
vim.keymap.set("n", "<C-J>", "<C-w>h", opt)
vim.keymap.set("n", "<C-K>", "<C-w>l", opt)

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
		"navarasu/onedark.nvim",
		priority = 1000, -- as the first plugin
		config = function()
			vim.cmd.colorscheme("onedark")
			require("onedark").setup({
				style = "darker",
			})
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
					component_separators = { left = "|", right = "|" },
				},
				extensions = { "nvim-tree" },
				sections = {
					lualine_c = {},
					lualine_x = {
						{
							"filename",
							path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
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
				disable_filetype = {
					"TelescopePrompt",
					"spectre_panel",
					"dap-repl",
					"guihua",
					"guihua_rust",
					"clap_input",
				},
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
		end,
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
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
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
				local opts = { buffer = bufnr }
				-- go xx
				vim.keymap.set("n", "gd", ":Lspsaga goto_definition<CR>", opts)
				vim.keymap.set("n", "gh", ":Lspsaga hover_doc<CR>", opts)
				vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
				vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				-- diagnostic
				vim.keymap.set("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
				vim.keymap.set("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
				vim.keymap.set("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
				vim.keymap.set("n", "<leader>=", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opt)
				vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opt)
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
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- For vsnip users.
					{ name = "vsnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				--mapping = require("keybindings").cmp(cmp),
				mapping = {
					-- auto-completion
					["<C-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					-- cancel
					["<C-,>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					-- prev one
					["<Up>"] = cmp.mapping.select_prev_item(),
					-- last one
					["<Down>"] = cmp.mapping.select_next_item(),
					["<CR>"] = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Replace,
					}),
				},
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
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
		end,
	},

	-- Null-ls(TODO: archived)
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting

			null_ls.setup({
				debug = false,
				sources = {
					-- Formatting ---------------------
					--  brew install shfmt
					formatting.shfmt,
					-- StyLua
					formatting.stylua,
					-- rustfmt
					formatting.rustfmt,
					-- go fmt
					formatting.goimports,
					-- frontend
					-- formatting.fixjson,
					-- formatting.black.with({ extra_args = { "--fast" } }),
				},
			})
		end,
	},
})

vim.o.background = "dark"
