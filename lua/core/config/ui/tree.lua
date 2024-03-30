local M = {}

M.configure = function()
	local nvim_tree_status, nvim_tree = pcall(require, "nvim-tree")

	if not nvim_tree_status then
		return
	end

	local function on_attach(bufnr)
		local api = require("nvim-tree.api")
		api.config.mappings.default_on_attach(bufnr)

	end

	nvim_tree.setup({
		on_attach = on_attach,
		sort_by = "case_sensitive",
		sync_root_with_cwd = true,
		view = {
			width = 25,
		},
		renderer = {
			group_empty = true,
			root_folder_label = ""
		},
		filters = {
			dotfiles = false,
		},
		diagnostics = {
			enable = false,
			show_on_dirs = true,
			severity = {
			  min = vim.diagnostic.severity.HINT,
			  max = vim.diagnostic.severity.ERROR,
			},
			icons = {
			  hint = "",
			  info = "",
			  warning = "",
			  error = "",
			}
		}
	})
end

return M
