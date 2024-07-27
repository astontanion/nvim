local M = {}

M.configure = function()
	local treesitter_configs_status, treesitter_configs = pcall(require, "nvim-treesitter.configs")

	if not treesitter_configs_status then
		return
	end

	treesitter_configs.setup({
		sync_install = false,
		auto_install = true,
		modules = {},
		ensure_installed = {
			"java",
			"kotlin",
			"typescript",
			"python",
			"lua",
			"vim",
			"vimdoc",
			"org",
			"css",
			"html",
			"tsx",
			"org",
		},
		ignore_install = {},
		highlight = {
			enable = true,
			disable = { "org" },
			additional_vim_regex_highlighting = { "org" },
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		rainbow = {
			enable = false,
			extended_mode = true,
			max_file_lines = nil,
		},
		autotag = {
			enable = true,
		},
	})

	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

	parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
end

return M
