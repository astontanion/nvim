return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},
	config = function()
		local config_status, config = pcall(require, "core.config.notes.markdown")

		if not config_status then
			return
		end

		config.configure()
	end,
	---@module 'render-markdown'
	---@type render.md.UserConfig
}
