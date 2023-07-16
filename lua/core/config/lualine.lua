local line_status, lualine = pcall(require, "lualine")

if not line_status then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
        theme = "auto",
        section_separators = "",
        component_separators = ""
	},
})
