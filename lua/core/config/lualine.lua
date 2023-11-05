local line_status, lualine = pcall(require, "lualine")

if not line_status then
	return
end

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand('%:p:h')
		local gitdir = vim.fn.finddir('.git', filepath .. ';')
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local config = {
	options = {
		icons_enabled = true,
		component_separators = "",
		section_separators = "",
		theme = vim.g.colors_name
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left {
	function()
		return ''
	end,
	padding = { left = 1, right = 1 },
}

ins_left {
	'filename',
	path = 4,
	color = { gui = 'bold' },
	cond = conditions.buffer_not_empty,
}

ins_left {
	'diagnostics', 
	sources = { 'nvim_lsp' },
	symbols = { error = ' ', warn = ' ', info = ' ' },
}

ins_left { 'location' }

ins_left { 'progress' }

ins_left {
	function()
		return '%='
	end,
}

ins_right {
	'o:encoding',
	fmt = string.lower,
	cond = conditions.hide_in_width,
}

ins_right {
	'filetype',
	fmt = string.lower,
	icons_enabled = true,
	padding = { left = 1, right = 1 },
}

lualine.setup(config)
