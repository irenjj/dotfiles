-- define your colorscheme here
local colorscheme = 'onedark'
local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end

require('onedark').setup  {
    style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
}

require('onedark').load()
