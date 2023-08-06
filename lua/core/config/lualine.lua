local line_status, lualine = pcall(require, "lualine")

if not line_status then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = vim.g.colors_name,
		section_separators = "",
		component_separators = ""
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'filename' },
		lualine_c = { 'diagnostics'},
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	}
})
