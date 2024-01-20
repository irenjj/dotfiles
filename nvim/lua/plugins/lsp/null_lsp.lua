local status, null_ls = pcall(require, "null-ls")
if not status then
    vim.notify("no null-ls found")
    return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
    debug = false,
    sources = {
        formatting.shfmt,
        -- StyLua
        formatting.stylua,
        -- rustfmt
        formatting.rustfmt,
    },
	on_attach = function(client)
        -- if client.server_capabilities.documentFormattingProvider then
        --	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format{ async = true}")
        -- end
    end,
})
