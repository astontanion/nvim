local which_key_status, which_key = pcall(require, "which-key")
local has_telescope, telescope = pcall(require, "telescope")
local has_builtin, builtin = pcall(require, "telescope.builtin")

if not which_key_status then return end
if not has_telescope then return end
if not has_builtin then return end

local file_browser = telescope.extensions.file_browser
local file_browser_actions = file_browser.actions

local file_keys = {
	name = "File",
	c = { file_browser_actions.create_from_prompt, "Create" },
	e = {
		function()
			local current_path = vim.fn.expand("%:p:h")
			file_browser.file_browser({ path = current_path })
		end,
		"Explore"
	},
	s = { builtin.find_files, "Search" },
}

local buffer_keys = {
	name = "Buffer",
	s = { builtin.buffers, "Search"},
}

local search_keys = {
	name = "Search",
	s = { builtin.live_grep, "Fuzzy" },
	g = { builtin.git_files, "In git" },
}

local mappings = {
	s = search_keys,
	f = file_keys,
	b = buffer_keys
}

local options = {
	mode = "n",
	prefix = "<leader>",
	silent = true,
	noremap = true
}

which_key.register(mappings, options)
