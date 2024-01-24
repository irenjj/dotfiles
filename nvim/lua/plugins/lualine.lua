local status, lualine = pcall(require, "lualine")
if not status then
    vim.notify("no lualine found")
    return
end

lualine.setup({
    options = {
        theme = "auto",
        component_separators = { left = "|", right = "|" },
    },
    extensions = { "nvim-tree", "toggleterm" },
    sections = {
        lualine_c = {
            "lsp_progress",
        },
        lualine_x = {
            "fileformat",
            {
                symbols = {
                    unix = ' ',
                    dos = ' ',
                    mac = ' ',
                },
            },
        },
    },
})
