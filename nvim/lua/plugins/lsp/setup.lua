local status, mason = pcall(require, "mason")
if not status then
    vim.notify("no mason found")
    return
end
mason.setup()

local status, mason_lsp = pcall(require, "mason-lspconfig")
if not status then
    vim.notify("no mason lsp config found")
    return
end
mason_lsp.setup({
    automatic_installation = true,
    ensure_installed = { "lua_ls", "rust_analyzer" },
})

function LspKeybind(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    require("keybindings").mapLSP(buf_set_keymap)
    -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format { async = true}")
end

local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
    vim.notify("no lspconfig found")
    return
end

-- lua
nvim_lsp.lua_ls.setup({
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
    on_attach = LspKeybind,
})

-- rust_analyzer
nvim_lsp.rust_analyzer.setup({
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
    on_attach = LspKeybind,
})
