vim.o.background = 'light'
------------------------------ Options ------------------------------
vim.opt.equalalways = false
vim.opt.listchars = { trail = "~", tab = "▸ ", space = "·" }
vim.g.mapleader = " "
vim.o.clipboard = "unnamed"
vim.wo.number = true
vim.opt.relativenumber = true
vim.wo.cursorline = false
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.incsearch = true
vim.o.cmdheight = 0
vim.o.autoread = true
vim.wo.wrap = true
vim.o.mouse = ""
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.list = true
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitright = true

-- Code folding.
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block-Cursor,r-cr-o:hor20"
vim.cmd [[
  augroup CursorColor
  autocmd!
  autocmd InsertEnter * highlight Cursor gui=NONE guifg=white guibg=orange
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

vim.keymap.set("n", "<Leader>w", ":bd!<CR>", opt)
vim.keymap.set("n", "<Leader>e", ":%bd|e#|bd#<CR>", opt)

vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")

-- More same behavior of 'k' and 'j' in wrapped lines
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Un-highlight last search result
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set("n", "<Leader>lg", ":vert Git blame -- %<CR>", opt)

-- json format
vim.keymap.set('n', '<leader>fj', function()
  vim.cmd([[%s/\v^"|"$//g]])
  vim.cmd([[%s/\\"/"/g]])
  vim.cmd([[silent! %!jq .]])
  vim.bo.filetype = 'json'
end, { desc = 'JSON unescape and format' })

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

local rainbow_highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

require("lazy").setup({
  -- Layout
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        on_colors = function(colors)
          colors.bg = "#ffffff"
          colors.dark = "#ffffff"
          colors.bg_float = "#ffffff"
          colors.popup = "#ffffff"
          colors.bg_sidebar = "#ffffff"
          colors.bg_statusline = "#dcdcdc"

          colors.bg_highlight = "#bbbbbb"
          colors.bg_visual = "#eeeeee"
          colors.fg_gutter = "#cccccc"
          colors.bg_search = "#e0e0e0"

          colors.green1 = "#E45649"
          colors.fg = "#555555"
        end,
        on_highlights = function(hl, _)
          hl["Comment"] = { fg = "#888888", italic = true }

          hl["@keyword"] = { fg = "#a626a4" }
          hl["@keyword.function"] = { fg = "#a626a4" }
          hl["Boolean"] = { fg = "#a626a4" }
          hl["Conditional"] = { fg = "#a626a4" }
          hl["Repeat"] = { fg = "#a626a4" }
          hl["Exception"] = { fg = "#a626a4" }

          hl["@variable.builtin"] = { fg = "#C18401" }
          hl["Type"] = { fg = "#C18401" }
          hl["Special"] = { fg = "#C18401" }
          hl["Constant"] = { fg = "#C18401" }

          hl["@variable.member"] = { fg = "#E45649" }
          hl["@variable.parameter.builtin"] = { fg = "#E45649" }

          hl["Function"] = { fg = "#4078F2" }
          hl["@constructor"] = { fg = "#4078F2" }

          hl["@variable.parameter"] = { fg = "#555555" }
          hl["@variable"] = { fg = "#555555" }
          hl["@punctuation.bracket"] = { fg = "#555555" }
          hl["@operator"] = { fg = "#555555" }

          hl["Search"] = { fg = "", bg = "#e0e0e0" }

          hl["StatusLine"] = { fg = "#303030", bg = "#dcdcdc" }
          hl["StatusLineNC"] = { fg = "#777777", bg = "#eeeeee" }

          hl["DiffAdd"] = { bg = "#dafbe1" }
          hl["DiffDelete"] = { bg = "#ffebe9" }
          hl["DiffChange"] = { bg = "NONE" }
          hl["DiffText"] = { bg = "NONE" }

          hl["DiffviewDiffAdd"] = { bg = "#dafbe1" }
          hl["DiffviewDiffAddAsDelete"] = { bg = "#ffebe9" }
          hl["DiffviewDiffDelete"] = { bg = "#ffebe9" }
          hl["DiffviewDiffDeleteDim"] = { bg = "#fff1f0" }
          hl["DiffviewDiffChange"] = { bg = "NONE" }
          hl["DiffviewDiffText"] = { bg = "NONE" }
          hl["DiffviewDiffTextAsAdd"] = { bg = "#aceebb" }
          hl["DiffviewDiffTextAsDelete"] = { bg = "#ffcecb" }

          hl["MatchParen"] = { bold = true, bg = "#eeeeee" }
          hl["LspInlayHint"] = { fg = "#b8b8b8", bg = "#ffffff" }

          hl["RenderMarkdownCode"] = { bg = "#e6f2f1" }
          hl["@markup.raw.markdown_inline"] = { bg = "#e6f2f1" }

          hl["MiniJump2dSpot"] = { fg = "#000000", bold = true, nocombine = true }
          hl["MiniJump2dSpotUnique"] = { fg = "#000000", bold = true, nocombine = true }
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "javascript",
          "json",
          "lua",
          "markdown",
          "python",
          "query",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        sync_install = false,
        auto_install = false,
        highlight = { enable = true },
        fold = { enable = true },
      })
    end,
  },
  -- outline
  {
    'stevearc/aerial.nvim',
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      layout = {
        default_direction = "float",
        min_width = { 0.8 },
      },
      keymaps = {
        ["<C-[>"] = "actions.close",
        ["?"] = "",
      },
      float = {
        relative = "win",
      },
    },
    vim.keymap.set("n", "<Leader>o", ":AerialToggle<CR>")
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-project.nvim',
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          layout_strategy = "vertical",
          preview = true,
          mappings = {
            n = {
              ["d"] = actions.delete_buffer,
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          buffers = { sort_mru = true },
          live_grep = { preview = true },
        },
        extensions = {
          project = {
            hidden_files = true,
          },
        },
      })

      vim.keymap.set("n", "<Leader>k", require("telescope.builtin").git_files)
      vim.keymap.set("n", "f", require("telescope.builtin").buffers)
      vim.keymap.set("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes'))<cr>", opts)

      vim.keymap.set('n', '<Leader>s', function()
        vim.ui.input({ prompt = "Grep arguments: " }, function(input)
          if input then
            local args = vim.split(input, ' ', { trimempty = true })
            local base_args = {"rg", "--color=never", "--no-heading", "--with-filename", 
                     "--line-number", "--column", "--smart-case"}
            for _, arg in ipairs(args) do
              table.insert(base_args, arg)
            end

            require('telescope.builtin').live_grep({
              vimgrep_arguments = base_args,
              preview = true,
            })
          end
        end)
      end)

      vim.keymap.set("n", "<leader>g", function()
        require("telescope.builtin").git_status()
      end, { desc = "Git status (Telescope)" })

      vim.api.nvim_set_keymap(
        'n',
        '<leader>p',
        ":lua require'telescope'.extensions.project.project{}<CR>",
        {noremap = true, silent = true}
      )

      require('telescope').load_extension('fzf')
      require'telescope'.load_extension('project')
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    ft = "python",
    opts = {},
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = false,
        current_line_blame_opts = { delay = 200 },

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

          map('n', '<leader>htc', gitsigns.toggle_current_line_blame)
          map('n', '<leader>htd', gitsigns.toggle_deleted)
        end
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local diffview_ibl_buffers = {}

      local function disable_ibl_for_current_diff_buffer(bufnr)
        local ok_ibl, ibl = pcall(require, "ibl")
        if not ok_ibl or not ibl.initialized then
          return
        end

        local tabpage = vim.api.nvim_get_current_tabpage()
        diffview_ibl_buffers[tabpage] = diffview_ibl_buffers[tabpage] or {}
        diffview_ibl_buffers[tabpage][bufnr] = true

        ibl.setup_buffer(bufnr, {
          enabled = false,
          scope = { enabled = false },
        })
      end

      local function restore_ibl_for_view(view)
        local ok_ibl, ibl = pcall(require, "ibl")
        local ok_conf, ibl_config = pcall(require, "ibl.config")
        if not ok_ibl or not ok_conf then
          return
        end

        local tracked = diffview_ibl_buffers[view.tabpage]
        if not tracked then
          return
        end

        for bufnr, _ in pairs(tracked) do
          if vim.api.nvim_buf_is_valid(bufnr) then
            ibl_config.clear_buffer_config(bufnr)
            ibl.refresh(bufnr)
          end
        end

        diffview_ibl_buffers[view.tabpage] = nil
      end

      local function set_diffview_local_opts()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.list = false
      end

      local function set_diffview_highlights()
        vim.api.nvim_set_hl(0, "DiffviewDiffAdd", { bg = "#dafbe1" })
        vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { bg = "#ffebe9" })
        vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { bg = "#ffebe9" })
        vim.api.nvim_set_hl(0, "DiffviewDiffDeleteDim", { bg = "#fff1f0" })
        vim.api.nvim_set_hl(0, "DiffviewDiffChange", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffviewDiffText", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffviewDiffTextAsAdd", { bg = "#aceebb" })
        vim.api.nvim_set_hl(0, "DiffviewDiffTextAsDelete", { bg = "#ffcecb" })
      end

      set_diffview_highlights()

      require("diffview").setup({
        hooks = {
          view_post_layout = function(view)
            if view.winopts and view.winopts.diff2 then
              view.winopts.diff2.a.winhl = {
                "DiffAdd:DiffviewDiffAddAsDelete",
                "DiffDelete:DiffviewDiffDeleteDim",
                "DiffChange:DiffviewDiffChange",
                "DiffText:DiffviewDiffTextAsDelete",
              }
              view.winopts.diff2.b.winhl = {
                "DiffDelete:DiffviewDiffDeleteDim",
                "DiffAdd:DiffviewDiffAdd",
                "DiffChange:DiffviewDiffChange",
                "DiffText:DiffviewDiffTextAsAdd",
              }
            end
          end,
          diff_buf_read = function(bufnr)
            -- Keep Diffview readable for long lines without affecting normal editing.
            set_diffview_local_opts()
            set_diffview_highlights()
            disable_ibl_for_current_diff_buffer(bufnr)
          end,
          diff_buf_win_enter = function(bufnr, _, _)
            set_diffview_local_opts()
            set_diffview_highlights()
            disable_ibl_for_current_diff_buffer(bufnr)
          end,
          view_leave = function(view)
            restore_ibl_for_view(view)
          end,
        },
      })
    end,
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local function toggle_inlay_hints()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end
      vim.keymap.set("n", "<Leader>i", toggle_inlay_hints)

      vim.lsp.config.clangd = {
        cmd = { "clangd" },
        filetypes = { "h", "c", "cpp", "tpp", "cc", "objc", "objcpp" },
        root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", ".git" },
        capabilities = capabilities,
      }
      vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
        pattern = {"*.tpp"},
        command = "set filetype=cpp"
      })


      vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic"
            }
          }
        }
      }
      -- Use Ruff's native language server for lint diagnostics; it reads the project's Ruff config.
      vim.lsp.config.ruff = {
        cmd = { "ruff", "server" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
      }

      vim.lsp.config.tsserver = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = { includeInlayParameterNameHints = "all" },
            preferences = { importModuleSpecifierPreference = "non-relative" },
          },
          javascript = {
            inlayHints = { includeInlayParameterNameHints = "all" },
          },
        },
      }

      vim.lsp.config.gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      }

      vim.lsp.enable({ "clangd", "gopls", "pyright", "ruff", "tsserver" })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gl", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist)
          vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>lf', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      -- Go: organize imports on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { "source.organizeImports" } }
          local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
          for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
              else
                vim.lsp.buf.execute_command(r.command)
              end
            end
          end
          vim.lsp.buf.format({ async = false })
        end,
      })
    end,
  },
  {
    'saghen/blink.cmp',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '1.*',
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'accept', 'select_next', 'fallback' },
      },
      completion = {
        documentation = {
          auto_show = true,
          window = {
            border = "rounded",
          },
        },
        ghost_text = { enabled = true }
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = {
            enabled = function()
              return vim.bo.filetype ~= 'markdown'
            end
          },
          buffer = {
            enabled = function()
              return vim.bo.filetype ~= 'markdown'
            end
          },
        }
      },
    },
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
            vim.keymap.set("n", "<leader>ld", ":RustLsp debug<CR>", opt)
            vim.keymap.set("n", "<leader>lp", ":RustLsp parentModule<CR>", opt)
            vim.keymap.set("n", "<leader>b", ":Cargo build -p datafusion-cli<CR>", opt)
            vim.keymap.set("n", "<leader>t", ":RustLsp testables<CR>", opt)

            -- None of this semantics tokens business.
            -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
            client.server_capabilities.semanticTokensProvider = nil
          end,
          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
              },
              completion = {
                postfix = {
                  enable = true,
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
      require('mini.pairs').setup()
      require("mini.surround").setup()
      require("mini.jump2d").setup()
      -- require("mini.indentscope").setup({
      --   draw = { animation = require("mini.indentscope").gen_animation.none() }
      -- })
      require("mini.cursorword").setup()
      require('mini.files').setup({
        mappings = { go_in_plus  = '<CR>' },

        vim.keymap.set('n', '<leader>j', function()
          local current_file = vim.api.nvim_buf_get_name(0)
          if current_file and current_file ~= '' then
            require('mini.files').open(current_file)
          else
            require('mini.files').open()
          end
        end, { desc = 'open file' })
      })
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "HiPhish/rainbow-delimiters.nvim",
        submodules = false,
        config = function()
          local rainbow_delimiters = require("rainbow-delimiters")

          vim.g.rainbow_delimiters = {
            strategy = {
              [""] = rainbow_delimiters.strategy["global"],
              vim = rainbow_delimiters.strategy["local"],
            },
            query = {
              [""] = "rainbow-delimiters",
              lua = "rainbow-blocks",
            },
            highlight = rainbow_highlight,
          }
        end,
      },
    },
    config = function()
      local whitespace_highlight = {
        "IndentRainbowRed",
        "IndentRainbowYellow",
        "IndentRainbowBlue",
        "IndentRainbowCyan",
      }
      local hooks = require("ibl.hooks")

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#de3d35" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#ccc733" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#2f5af3" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#d98e04" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#3e953a" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#a463f2" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#11bab7" })
        vim.api.nvim_set_hl(0, "IndentRainbowRed", { fg = "#c85b64", bg = "#f9eceb" })
        vim.api.nvim_set_hl(0, "IndentRainbowYellow", { fg = "#b89a32", bg = "#f7f5e8" })
        vim.api.nvim_set_hl(0, "IndentRainbowBlue", { fg = "#356dff", bg = "#e7eeff" })
        vim.api.nvim_set_hl(0, "IndentRainbowCyan", { fg = "#0e9f9c", bg = "#e9f7f6" })
      end)

      require("ibl").setup({
        indent = {
          highlight = rainbow_highlight,
          char = "",
          tab_char = "",
        },
        whitespace = {
          highlight = whitespace_highlight,
          remove_blankline_trail = true,
        },
        scope = {
          enabled = true,
          highlight = rainbow_highlight,
          show_start = false,
          show_end = false,
        },
        exclude = {
          filetypes = {
            "aerial",
            "checkhealth",
            "dashboard",
            "DiffviewFiles",
            "DiffviewFileHistory",
            "gitcommit",
            "help",
            "lazy",
            "markdown",
            "minifiles",
            "qf",
            "TelescopePrompt",
            "",
          },
          buftypes = { "nofile", "quickfix", "terminal" },
        },
      })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
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
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_filetypes = { "markdown" }
      vim.keymap.set("n", "<Leader>mp", ":MarkdownPreview<CR>", opt)
    end,
    ft = { "markdown" },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  },
  {
    "pteroctopus/faster.nvim",
    config = function()
      require('faster').setup({
        suggestion = { auto_trigger = true },
      })
    end
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
    config = function()
      require('dressing').setup({ select = { telescope = { min_width = 0.9 } } })
    end
  },
  {
    "Pocco81/auto-save.nvim",
    opts = { enabled = true },
  },
})
