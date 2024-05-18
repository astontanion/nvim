return {
	"folke/which-key.nvim",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		plugins = {
			marks = false,
			registers = false
		},
		window = {
			boarder = "single",
			position = "bottom",
			margin = { 1, 0, 1, 0 },
			pading = { 1, 1, 1, 1 },
		},
		layout = {
			height = { min = 1, max = 10 },
			spacing = 3,
			align = "center"
		}
	}
}
