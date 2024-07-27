local M = {}

M.configure = function()
	local which_key_status, which_key = pcall(require, "which-key")
	local has_telescope, telescope = pcall(require, "telescope")
	local has_builtin, builtin = pcall(require, "telescope.builtin")

	if not which_key_status then
		return
	end
	if not has_telescope then
		return
	end
	if not has_builtin then
		return
	end

	local file_browser = telescope.extensions.file_browser
	local file_browser_actions = file_browser.actions

	local file_keys = {
		{ mode = "n" },
		{ lhs = "<leader>f", group = "file" },
		{
			lhs = "<leader>fe",
			rhs = function()
				local current_path = vim.fn.expand("%:p:h")
				file_browser.file_browser({ path = current_path })
			end,
			desc = "Explore",
		},
		{ lhs = "<leader>fs", rhs = builtin.find_files, desc = "Search" },
	}

	local buffer_keys = {
		{ mode = "n" },
		{ lhs = "<leaderb>", group = "buffer" },
		{ lhs = "<leader>bs", rhs = builtin.buffers, desc = "Search" },
		{ lhs = "<leader>bc", rhs = builtin.spell_suggest, desc = "Checker" },
	}

	local search_keys = {
		{ mode = "n" },
		{ lhs = "<leader>s", group = "search" },
		{ lhs = "<leader>ss", rhs = builtin.live_grep, desc = "Fuzzy" },
		{ lhs = "<leader>sg", rhs = builtin.git_files, desc = "In git" },
	}

	local help_keys = {
		{ mode = "n" },
		{ lhs = "<leader>h", group = "help" },
		{ lhs = "<leader>ho", rhs = builtin.help_tags, desc = "Open" },
	}

	which_key.add(file_keys)
	which_key.add(buffer_keys)
	which_key.add(search_keys)
	which_key.add(help_keys)
end

return M
