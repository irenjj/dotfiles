-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
    vim.notify("no nvim-tree found")
    return
end

nvim_tree.setup({
    sort_by = "case_sensitive",
    git = {
        enable = true,
    },
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
--    filters = {
--        dotfiles = true,
--        custom = { "node_modules" },
--    },
    view = {
        width = 30,
        side = "left",
        number = false,
        relativenumber = false,
        signcolumn = "yes",
    },
    renderer = {
        group_empty = true,
        icons = {
            show = {
                git = true,
                file = true,
                folder = true,
                folder_arrow = true,
            },
        },
    },
    actions = {
        open_file = {
            resize_window = true,
            quit_on_open = true,
        },
    },
    system_open = {
        cmd = "open",
    },
})
