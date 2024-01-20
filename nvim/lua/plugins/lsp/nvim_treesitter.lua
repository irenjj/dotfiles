local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    vim.notify("no nvim-treesitter found")
    return
end

treesitter.setup({
    ensure_installed = {
        "json",
        "vim",
        "lua",
        "rust",
        "c",
        "cpp",
    },
    highlight = {
        enable = true,
--        additional_vim_regex_highlighting = false,
--        disable = function(lang, buf)
--            local max_filesize = 100 * 1024 -- 100 KB
--            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--            if ok and stats and stats.size > max_filesize then
--                return true
--            end
--        end,
    },
--    incremental_selection = {
--        enable = true,
--        keymaps = {
--            init_selection = "<CR>",
--            node_incremental = "<CR>",
--            node_decremental = "<BS>",
--            scope_incremental = "<TAB>",
--        },
--    },
})
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.gotmpl = {
    install_info = {
        url = "https://github.com/ngalaiko/tree-sitter-go-template",
        files = { "src/parser.c" },
    },
    filetype = "gotmpl",
    used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml", "tpl" },
}
