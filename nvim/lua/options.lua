-- System clipboard
vim.o.clipboard = 'unnamed'

-- Utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

-- Line number
vim.wo.number = true

-- Highlight current line
-- vim.wo.cursorline = true

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

-- Command heightl
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
vim.o.background = "dark"
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

