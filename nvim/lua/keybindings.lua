-- Rebind leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = { noremap = true, silent = true }

-- ----------------- Bufferline -----------------
-- Switch between tabs
vim.api.nvim_set_keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
vim.api.nvim_set_keymap("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- Close current tab
vim.api.nvim_set_keymap("n", "<C-w>", ":Bdelete!<CR>", opt)

-- Keybindings for plugin keys
local pluginKeys = {}

-- ----------------- Telescope Plugin -----------------
pluginKeys.telescopeList = {
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
}
-- Find file
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- Global search
vim.api.nvim_set_keymap("n", "<C-g>", ":Telescope live_grep<CR>", opt)

-- ----------------- Nvim-tree -----------------
pluginKeys.nvimTreeList = {
    -- Open file or directory
    { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
    -- Show hidden files
    { key = "i", action = "toggle_custom" },
    { key = ".", action = "toggle_dotfiles" },
    -- File operations
--    { key = "<F5>", action = "refresh" },
    { key = "a", action = "create" },
--    { key = "d", action = "remove" },
--    { key = "r", action = "rename" },
--    { key = "x", action = "cut" },
--    { key = "c", action = "copy" },
--    { key = "p", action = "paste" },
--    { key = "s", action = "system_open" },
}
-- Open/close tree
vim.api.nvim_set_keymap("n", "<C-f>", ":NvimTreeToggle<CR>", opt)

-- ----------------- lsp -----------------
pluginKeys.mapLSP = function(mapbuf)
    -- rename
    mapbuf("n", "<leader>r", ":Lspsaga rename<CR>", opt)
    -- code action
    mapbuf("n", "<leader>ca", ":Lspsaga code_action<CR>", opt)
    -- go xx
    mapbuf("n", "gd", ":Lspsaga goto_definition<CR>", opt)
    mapbuf("n", "gh", ":Lspsaga hover_doc<CR>", opt)
    mapbuf("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opt)
    mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
    mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
    mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
    -- diagnostic
    mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
    mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
    mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)

    mapbuf("n", "<leader>=", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opt)
    mapbuf("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opt)
end

-- nvim-cmp
pluginKeys.cmp = function(cmp)
    return {
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
        -- scroll 
 --       ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
 --       ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    }
end


return pluginKeys
