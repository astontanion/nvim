local neorg_status, neorg = pcall(require, "neorg")

if not neorg_status then return end

neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {
			config = {
				folds = true,
				icon_preset = "basic",
			}
		},
		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/doc/org/notes"
				},
				default_workspace = "notes",
				index = "index.norg",
				use_popup = true
			}
		}
	}
})
