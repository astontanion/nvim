local tree_api_status, tree_api  = pcall(require, "nvim-tree.api")
local key_status, which_key = pcall(require, "which-key")

if not tree_api_status then return end
if not key_status then return end

local tree_keys = {
	name = "tree",
	f = { tree_api.tree.focus, "Focus" },
	c = { tree_api.tree.collapse_all, "Collapse all" },
	t = { tree_api.tree.toggle, "Open" },
	s = {
		function()
			local current_path = vim.fn.expand("%:p")
			tree_api.tree.open()
			tree_api.tree.collapse_all()
			tree_api.tree.find_file(current_path)
		end,
		"Searh"
	},
}

local mappings = {
	t = tree_keys
}

local options = {
	mode = "n",
	prefix = "<leader>",
	silent = true,
	noremap = true
}

which_key.register(mappings, options)
