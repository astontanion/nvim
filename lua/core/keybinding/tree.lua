local M = {}

M.configure = function()
	local tree_api_status, tree_api = pcall(require, "nvim-tree.api")
	local key_status, which_key = pcall(require, "which-key")

	if not tree_api_status then
		return
	end
	if not key_status then
		return
	end

	local tree_keys = {
		{ mode = "n" },
		{ lhs = "<leader>t", group = "tree" },
		{ lhs = "<leader>tf", rhs = tree_api.tree.focus, desc = "Focus" },
		{ lhs = "<leader>tc", rhs = tree_api.tree.collapse_all, desc = "Collapse all" },
		{ lhs = "<leader>tt", rhs = tree_api.tree.toggle, desc = "open" },
		{
			lhs = "<leader>ts",
			rhs = function()
				local current_path = vim.fn.expand("%:p")
				tree_api.tree.open()
				tree_api.tree.collapse_all()
				tree_api.tree.find_file(current_path)
			end,
			desc = "Searh",
		},
	}

	which_key.add(tree_keys)
end

return M
