return {
	"folke/which-key.nvim",
	dependencies = {
		"echasnovski/mini.icons",
	},
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local config_status, config = pcall(require, "core.config.ui.which-key")

		if not config_status then
			return
		end

		config.configure()
	end,
}
