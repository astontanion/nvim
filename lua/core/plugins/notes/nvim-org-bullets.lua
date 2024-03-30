return {
	"akinsho/org-bullets.nvim",
	dependencies = {
		'nvim-orgmode/orgmode',
	},
	config = function()
		local config_status, config = pcall(require, "core.config.org-bullets")
		if not config_status then return end
		config.configure()
	end
}
