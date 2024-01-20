local status, cmp = pcall(require, "cmp")
if not status then
    vim.notify("no cmp found")
    return
end

local status, lspkind = pcall(require, "lspkind")
if not status then
    vim.nofity("no lspkind found")
    return
end

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
    }, { { name = "buffer" }, { name = "path" } }),

    mapping = require("keybindings").cmp(cmp),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",

            before = function(_, vim_item)
                return vim_item
            end,
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
