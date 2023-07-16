local tree_status, tree = pcall(require, "nvim-tree")

if not tree_status then
	return
end

tree.setup({
	sort_by = "case_sensitive",
    sync_root_with_cwd = true,
	view = {
		width = 25,
        hide_root_folder = true,
		mappings = {
			custom_only = true,
			list = {}
		}
	},
	renderer = {
		group_empty = true,
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
