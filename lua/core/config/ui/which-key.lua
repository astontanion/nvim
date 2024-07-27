local M = {}

M.configure = function()
	local which_key_status, which_key = pcall(require, "which-key")

	if not which_key_status then
		return
	end

	which_key.setup({
		preset = "classic",
		plugins = {
			marks = false,
			registers = false,
			spelling = {
				enabled = false,
				suggestions = 20,
			},
		},
		win = {
			height = { min = 1, max = 10 },
			row = -1,
			padding = { 1, 1 },
			title = true,
			title_pos = "center",
		},
		layout = {
			width = { min = 20, max = 20 },
			spacing = 3,
			align = "center",
		},
		expand = 0,
	})
end

return M
