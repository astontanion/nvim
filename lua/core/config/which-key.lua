local which_key_status, which_key = pcall(require, "which-key")

if not which_key_status then return end

which_key.setup({
    plugins = {
        marks = false,
        registers = false
    },
    window = {
        boarder = "single",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        pading = { 1, 1, 1, 1 },
    },
    layout = {
        height = { min = 1, max = 10 },
        spacing = 3,
        align = "center"
    }
})
