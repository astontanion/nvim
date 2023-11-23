local has_treesitter, treesitter = pcall(require, "nvim-treesitter.configs")

if not has_treesitter then return end

treesitter.setup {
	ensure_installed = {
		"java",
		"kotlin",
		"typescript",
		"python",
		"lua",
		"vim",
		"org",
		"css",
		"html",
		"tsx"
	},
	ignore_install = {},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = {'org'},
		additional_vim_regex_highlighting = {"org"}
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			code_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		}
	},
	rainbow = {
		enable = false,
		extended_mode = true,
		max_file_lines = nil,
	},
	autotag = {
		enable = true
	}
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.org = {
	install_info = {
		url = 'https://github.com/milisims/tree-sitter-org',
		revision = 'main',
		files = { 'src/parser.c', 'src/scanner.c' },
	},
	filetype = 'org',
}

parser_config.tsx = {
	filetype_to_parsername = { "javascript", "typescript.tsx" }
}
