return {
	'nvim-orgmode/orgmode',
	dependencies = {
		{ 'nvim-treesitter/nvim-treesitter', lazy = true },
	},
	event = 'VeryLazy',
	config = function()
		local config_status, config = pcall(require, "core.config.notes.orgmode")
		if not config_status then return end
		config.configure()
	end
}
