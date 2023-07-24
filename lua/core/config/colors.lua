local colors_scheme = "catppuccin-macchiato"

local is_success, _ = pcall(vim.cmd, "colorscheme " .. colors_scheme)

if not is_success then
    vim.notify("The colors scheme " .. colors_scheme .. " was not found!")
end
