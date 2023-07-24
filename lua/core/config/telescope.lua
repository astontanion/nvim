local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then return end

local file_browser = telescope.extensions.file_browser
local file_browser_actions = file_browser.actions

telescope.setup({
	defaults = {
		path_display = {
			sorten = {
				len = 3,
				exclude = { 1, -1 },
			},
			truncate = true
		},
		dynamic_preview_title = true
	},
	extensions = {
		file_browser = {
			-- theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					["f"] = false,
					["fn"] = file_browser_actions.create,
					["fd"] = file_browser_actions.remove,
					["fr"] = file_browser_actions.rename,
					["fm"] = file_browser_actions.move,
				},
			},
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown {}
		}
	}
})

telescope.load_extension("file_browser")
telescope.load_extension("ui-select")
