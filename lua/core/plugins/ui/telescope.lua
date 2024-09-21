return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/which-key.nvim",
	},
	config = function()
		local config_status, config = pcall(require, "core.config.ui.telescope")

		if not config_status then
			return
		end

		config.configure()

		local mapping_status, mapping = pcall(require, "core.keybinding.telescope")

		if not mapping_status then
			return
		end

		mapping.configure()
	end,
}
